/**
 * Developed by Lancelotmobile Ltd. (c) 2012
 * http://www.lancelotmobile.com
 *
 * Copyright (c) 2012 Lancelotmobile.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 **/
/**
 * Native ads extension implementation for AIR
 */
package com.lancelotmobile.ane;

import java.util.HashMap;
import java.util.Map;

import android.app.Activity;
import android.graphics.Rect;
import android.util.Log;
import android.widget.RelativeLayout;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.google.ads.Ad;
import com.google.ads.AdListener;
import com.google.ads.AdRequest.ErrorCode;
import com.google.ads.AdSize;
import com.google.ads.AdView;

/**
 * Main class where all exposed functions are registered.
 * @author emil
 *
 */
public class NativeAdsContext extends FREContext {

	private static final String TAG = NativeAdsContext.class.getName();
	private String _unitId;
	private Boolean _inRealMode;
	private AdView _adView;
	private Rect _bannerRect;
	private RelativeLayout _adHolder;
	
	@Override
	public void dispose() {
		//clean up
		if(_adHolder != null)
		{
			_adHolder.removeAllViews();
		}
		_adHolder = null;
		_adView = null;
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		_inRealMode = false;
		Log.d(TAG, "NativeAdsExtension compose function map.");
		
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		functionMap.put("initAd", new NativeAdsInitAdFunction());
		functionMap.put("setAdMode", new NativeAdsSetAdModeFunction());
		functionMap.put("setUnitId", new NativeAdsSetUnitIdFunction());
		functionMap.put("showAd", new NativeAdsShowAdFunction());
		functionMap.put("hideAd", new NativeAdsHideAdFunction());
		functionMap.put("removeAd", new NativeAdsRemoveAdFunction());
	    return functionMap;
	}

	public void saveUnitId(String _unitId) {
		this._unitId = _unitId;
	}

	public String getUnitId() {
		return _unitId;
	}

	public void setInRealMode(Boolean _inRealMode) {
		this._inRealMode = _inRealMode;
	}

	public Boolean getInRealMode() {
		return _inRealMode;
	}
	
	public void createAd(Activity act) {
		_adView = new AdView(act, AdSize.BANNER, _unitId);
		final NativeAdsContext context = this;
		_adView.setAdListener(new AdListener() {
	            @Override
	            public void onFailedToReceiveAd(Ad ad, ErrorCode error) {
	            	context.dispatchStatusEventAsync("AD_ERROR", "AD_ERROR_LEVEL");
	            }

	            @Override
	            public void onReceiveAd(Ad ad) {
	            	context.dispatchStatusEventAsync("AD_RECEIVED", "AD_RECEIVED_LEVEL");
	            }

				@Override
				public void onDismissScreen(Ad arg0) {
					
				}

				@Override
				public void onLeaveApplication(Ad arg0) {
					
				}

				@Override
				public void onPresentScreen(Ad arg0) {
					context.dispatchStatusEventAsync("AD_CLICKED", "AD_CLICKED_LEVEL");
				}
	        });

	}
	
	public void dismissAd() {
		_adView = null;
		if(_adHolder != null)
		{
			_adHolder.removeAllViews();
			_adHolder = null;
		}
	}
	
	public AdView getAd() {
		return _adView;
	}
	
	public void setBannerRect(Rect _bannerRect) {
		this._bannerRect = _bannerRect;
	}

	public Rect getBannerRect() {
		return _bannerRect;
	}

	public void setAdHolder(RelativeLayout _adHolder) {
		this._adHolder = _adHolder;
	}

	public RelativeLayout getAdHolder() {
		return _adHolder;
	}

}
