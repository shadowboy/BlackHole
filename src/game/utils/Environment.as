package game.utils 
{
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author Andy Cao
	 */
	public class Environment 
	{
		public static const WINDOW_TYPE:String = "WindowType";
		public static const FULLSCREEN_TYPE:String = "FullscreenType";
		//devices
		//IOS
		public static const IPAD:String = "iPad";
		public static const IPHONE:String = "iPhone";
		public static const IPHONE_RETINA:String = "iPhoneRetina";
		//Android
		
		//instance
		public static var instance:Environment;
		
		/**
		 * get instatnce
		 * @return
		 */
		public static function getInstance():Environment
		{
			if (instance == null)
				instance = new Environment();
			return instance;
		}
		
		private var _os:String;
		private var _screenWidth:int;
		private var _screenHeight:int;
		private var _dpi:int
		private var _showType:String;
		private var _device:String;
		
		public function Environment() 
		{
			_os = Capabilities.os;
            trace("os:"+_os);
			_screenWidth = Capabilities.screenResolutionX;
			_screenHeight = Capabilities.screenResolutionY;
			_dpi = Capabilities.screenDPI;
			
			if (_os.indexOf("Windows") != -1 || _os.indexOf("Mac") != -1 || _os.indexOf("Linux") != -1)
			{
				//desktop
				_showType = WINDOW_TYPE;
			}
			else
			{
				_showType = FULLSCREEN_TYPE;
				//phones pocket pc ipad or 
				if (_os.indexOf("IOS") != -1)
				{
					if (_screenWidth == 320)
					{
						//before iphone4
						_device = IPHONE;
					}
					else if (_screenWidth == 640)
					{
						//iphone 4  iphone 4s
						_device = IPHONE_RETINA;
					}
					else if (_screenWidth == 768)
					{
						//ipad
						_device = IPAD;
					}
				}
				
				//Android decive
			}
		}
		
		public function get showType():String 
		{
			return _showType;
		}
		
		public function get screenWidth():int 
		{
			return _screenWidth;
		}
		
		public function get screenHeight():int 
		{
			return _screenHeight;
		}
		
		public function get dpi():int 
		{
			return _dpi;
		}
		
		public function get device():String 
		{
			return _device;
		}
	}
}