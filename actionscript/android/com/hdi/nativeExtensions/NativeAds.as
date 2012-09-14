package com.hdi.nativeExtensions
{
	import flash.external.ExtensionContext;
	import flash.events.EventDispatcher;
    import flash.events.StatusEvent;

	public class NativeAds
	{
		private static var extensionContext : ExtensionContext = null;
		private static var adVisible:Boolean = false;
		private static var _dispatcher:EventDispatcher;
		
		
		private static var _x:int;
		private static var _y:int;
		private static var _w:int;
		private static var _h:int;
		private static var _wasVisible:Boolean = false;
		
		public static const BANNER:int                 = 0;
		public static const IAB_BANNER_468_25:int      = 1;
		public static const IAB_LEADERBOARD_728_90:int = 2;
		public static const IAB_MRECT_300_25:int       = 3;

		
		
		private static function initExtension():void
		{
			if ( !extensionContext)
			{
				extensionContext = ExtensionContext.createExtensionContext( "com.hdi.nativeExtensions.NativeAds", null );
				extensionContext.addEventListener( StatusEvent.STATUS, onAdHandler );
			}
		}
		
		private static function onAdHandler( event : StatusEvent ) : void
        {
            if( event.code == NativeAdsEvent.AD_CLICKED )
            {
                dispatcher.dispatchEvent( new NativeAdsEvent(NativeAdsEvent.AD_CLICKED));
            } else if(event.code == NativeAdsEvent.AD_ERROR)
			{
				dispatcher.dispatchEvent( new NativeAdsEvent(NativeAdsEvent.AD_ERROR));
			} 	else if(event.code == NativeAdsEvent.AD_RECEIVED)
			{
				dispatcher.dispatchEvent( new NativeAdsEvent(NativeAdsEvent.AD_RECEIVED));
			}
        }
		
		/**
		 * Is the extension supported
		 */
		public static function get isSupported() : Boolean
		{
			initExtension();
			return extensionContext ? true : false;
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
			initExtension();
			extensionContext.call("setUnitId",unitId);
		}
		
		/**
		 * set ad mode
		 */
		public static function setAdMode(isInRelaMode:Boolean): void
		{
			initExtension();
			extensionContext.call("setAdMode",isInRelaMode);
		}
		
		/**
		 * Init ad on a screen, in the specified rectangle
		 */
		public static function initAd( x:int, y:int, width:int, height:int, bannerType:int = 0 ) : void
		{
			initExtension();
			if(extensionContext)
			{
			
				extensionContext.call( "initAd", x, y, width, height, bannerType );
			}	
		}

		/**
		 * Show ad on a screen, in the specified rectangle
		 */
		public static function showAd( x:int, y:int, width:int, height:int ) : void
		{
			if(!adVisible)
			{
				initExtension();
				if(extensionContext)
				{
					//record last position
					_x = x; _y = y;
					_w = width; _h = height;
					
					extensionContext.call( "showAd", x, y, width, height );
					adVisible = true;
				}

			}
			
		}
		
		public static function restoreAd():void
		{
			if(_wasVisible)
			{
				showAd(_x,_y,_w,_h);
				_wasVisible = false;
			}
		}
		
		public static function deactivateAd():void
		{
			if(adVisible)
			{
				initExtension();
				if(extensionContext)
				{
				
						extensionContext.call("hideAd");
						adVisible = false;
						_wasVisible =  true;
				
				}
			}
		}
		
		/**
		 * Hide ad
		 */
		public static function hideAd() : void
		{
			if(adVisible)
			{
				initExtension();
				if(extensionContext)
				{
					extensionContext.call("hideAd");
					adVisible = false;
				}
			}
		}
		
		
		/**
		 * Hide ad
		 */
		public static function removeAd() : void
		{
			initExtension();
			if(extensionContext)
			{
				extensionContext.call("removeAd");
				adVisible = false;
				_wasVisible = false;
			}

		}
		
		/**
		 * Clean up the extension - only if you no longer need it or want to free memory.
		 */
		public static function dispose() : void
		{
			if( extensionContext )
			{
                extensionContext.removeEventListener( StatusEvent.STATUS, onAdHandler );
				extensionContext.dispose();
				extensionContext = null;
				adVisible = false;
			}
		}
	}
}

