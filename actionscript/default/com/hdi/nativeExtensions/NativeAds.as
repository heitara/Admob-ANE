package com.hdi.nativeExtensions
{
	import flash.events.EventDispatcher;

	public class NativeAds
	{
		private static var adVisible:Boolean = false;
		private static var _dispatcher:EventDispatcher;
		
		private static var _x:int;
		private static var _y:int;
		private static var _w:int;
		private static var _h:int;
		private static var _wasVisible:Boolean = false;
	
		/**
		 * Is the extension supported
		 */
		public static function get isSupported() : Boolean
		{
			trace("[com.hdi.nativeExtensions.NativeAds]"," default implementation");
			return true;
		}
		
		public static function get dispatcher():EventDispatcher
		{
			if(!_dispatcher)
			{
				_dispatcher = new EventDispatcher();
			}
			return _dispatcher;
		}
		
		/**
		 * set unit id
		 */
		public static function setUnitId(unitId:String): void
		{
			trace("[com.hdi.nativeExtensions.NativeAds]"," setUnitId");
		}
		
		/**
		 * set ad mode
		 */
		public static function setAdMode(isInRelaMode:Boolean): void
		{
			trace("[com.hdi.nativeExtensions.NativeAds]"," setAdMode ", isInRelaMode);
		}
		
		/**
		 * Init ad on a screen, in the specified rectangle
		 */
		public static function initAd( x:int, y:int, width:int, height:int ) : void
		{
				trace("[com.hdi.nativeExtensions.NativeAds]"," initAd");
		}

		/**
		 * Show ad on a screen, in the specified rectangle
		 */
		public static function showAd( x:int, y:int, width:int, height:int ) : void
		{
			if(!adVisible)
			{
				trace("[com.hdi.nativeExtensions.NativeAds]"," showAd");
				_x = x; _y = y;
				_w = width; _h = height;
				adVisible = true;
				
			}
			
		}
		
		public static function restoreAd():void
		{
			trace("[com.hdi.nativeExtensions.NativeAds]"," restore Ad");
			if(_wasVisible)
			{
				trace("[com.hdi.nativeExtensions.NativeAds]","restore (show Ad)");
				showAd(_x,_y,_w,_h);
				_wasVisible = false;
			}
		}
		
		public static function deactivateAd():void
		{
			trace("[com.hdi.nativeExtensions.NativeAds]"," deactivate Ad");
			if(adVisible)
			{
				trace("[com.hdi.nativeExtensions.NativeAds]"," deactivate (hide Ad)");
				adVisible = false;
				_wasVisible =  true;
			}
		}
		
		/**
		 * Hide ad
		 */
		public static function hideAd() : void
		{
			if(adVisible)
			{
				trace("[com.hdi.nativeExtensions.NativeAds]"," hideAd");
				adVisible = false;
			}
		}
		
		
		/**
		 * Hide ad
		 */
		public static function removeAd() : void
		{
			trace("[com.hdi.nativeExtensions.NativeAds]"," removeAd");
			adVisible = false;
			_wasVisible =  false;
		}
		
		/**
		 * Clean up the extension - only if you no longer need it or want to free memory.
		 */
		public static function dispose() : void
		{
			trace("[com.hdi.nativeExtensions.NativeAds]"," dispose");
			adVisible = false;
		}
	}
}



