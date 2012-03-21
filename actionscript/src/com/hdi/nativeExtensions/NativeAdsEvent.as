package com.hdi.nativeExtensions
{
	import flash.events.Event;
	
	public class NativeAdsEvent extends Event
	{
		/**
		 * Event which will be fired when an ad is clicked.
		 */
		public static const AD_CLICKED:String = "AD_CLICKED";
		/**
		 * Event which will be fired when there is an error with the ad or with the admob service.
		 */
		public static const AD_ERROR:String = "AD_ERROR";
		/**
		 * Event which will be fired when an ad is received from admob service.
		 */
		public static const AD_RECEIVED:String = "AD_RECEIVED";
		public function NativeAdsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}