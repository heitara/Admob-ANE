package com.hdi.nativeExtensions
{
	import flash.events.Event;
	
	public class NativeAdsEvent extends Event
	{
		public static const AD_CLICKED:String = "AD_CLICKED";
		public static const AD_ERROR:String = "AD_ERROR";
		public static const AD_RECEIVED:String = "AD_RECEIVED";
		public function NativeAdsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}