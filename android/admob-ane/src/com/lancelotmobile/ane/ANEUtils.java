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
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.FrameLayout.LayoutParams;
import android.widget.RelativeLayout;

public class ANEUtils {
	/**
	 * Position and resize view in parent view.
	 * @param v The view which should be positioned
	 * @param rect
	 */
	public static void positionAndResizeView(View v, Rect rect) {
    	RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(v.getLayoutParams().width, v.getLayoutParams().height);
		params.setMargins(rect.left, rect.top, 0, 0);
		v.setLayoutParams(params);
    }
    /**
     * Add a view to the display list on top of all views in an activity.
     * @param act Activity which should be use to create a view
     * @param v the view which will be added 
     * @param rect size and position of the added view
     * @return relative layout which contains the passed view.
     */
    public static RelativeLayout addView(Activity act, View v, Rect rect) {
    	RelativeLayout rl = new RelativeLayout(act);

    	ViewGroup fl = (ViewGroup)act.findViewById(android.R.id.content);
		fl = (ViewGroup)fl.getChildAt(0);
		
		fl.addView(rl, new FrameLayout.LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT));
		
		RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(rect.width(), rect.height());
		params.setMargins(rect.left, rect.top, 0, 0);
		rl.addView(v, params);
		
		return rl;
    }
}
