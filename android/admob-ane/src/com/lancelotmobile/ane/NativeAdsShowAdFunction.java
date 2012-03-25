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
package com.lancelotmobile.ane;

import android.app.Activity;
import android.graphics.Rect;
import android.view.View;
import android.widget.RelativeLayout;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;
import com.google.ads.AdRequest;
import com.google.ads.AdView;

public class NativeAdsShowAdFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		FREObject param;
		
		try {
			param  = args[0];
			int x = param.getAsInt();
			param  = args[1];
			int y = param.getAsInt();
			param  = args[2];
			int w = param.getAsInt();
			param  = args[3];
			int h = param.getAsInt();
			NativeAdsContext cnt = (NativeAdsContext) context;
			cnt.setBannerRect(new Rect(x, y, x + w, y + h));

			AdView adView = cnt.getAd();
			Activity act = context.getActivity();
			
			RelativeLayout rl = cnt.getAdHolder();
			if(rl == null)
			{
				rl = ANEUtils.addView(act, adView, cnt.getBannerRect());
				cnt.setAdHolder(rl);
			}
			else
			{
				ANEUtils.positionAndResizeView(adView, cnt.getBannerRect());
			}
			
			adView.setVisibility(View.VISIBLE);
			
			AdRequest request = new AdRequest();
			if(!cnt.getInRealMode()) {
				request.addTestDevice(AdRequest.TEST_EMULATOR);
				request.addTestDevice("E0C4240FEDAFFECE52E8419E208EA3A7");
			}

			adView.loadAd(request);
			
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (FRETypeMismatchException e) {
			e.printStackTrace();
		} catch (FREInvalidObjectException e) {
			e.printStackTrace();
		} catch (FREWrongThreadException e) {
			e.printStackTrace();
		}
		
		
		return null;
	}

}
