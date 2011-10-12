package game
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class BaseOtherState extends FlxState 
	{
		protected var _bg:FlxSprite;
		protected var _bgFlx:FlxSprite;
		
		protected var _titleField:FlxText;
		protected var _introField:FlxText;
		protected var _backBtn:FlxButton;
		
		public function BaseOtherState(title:String,bgClass:Class=null) 
		{
			super();
			trace(bgClass);
			if (bgClass)
			{
				_bg = new FlxSprite();
				_bg.loadGraphic(bgClass, false, false, FlxG.width, FlxG.height);
				trace(_bg);
				add(_bg);
			}
			
			_titleField = new FlxText(0, 0, 100, title);
			add(_titleField);
			
			_backBtn = new FlxButton(FlxG.width-100, FlxG.height-20, "back", backHandler);
			add(_backBtn);
		}
		
		private function backHandler():void 
		{
			FlxG.switchState(new MenuState());
		}
		
	}

}