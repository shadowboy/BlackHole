package game.test
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.PauseState;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class Test extends FlxState 
	{
		protected var _bg:FlxSprite;
		protected var _bgFlx:FlxSprite;
		
		protected var _titleField:FlxText;
		protected var _introField:FlxText;
		protected var _backBtn:FlxButton;
		
		public function Test() 
		{
			super();
			FlxG.mouse.show();
			_bg = new FlxSprite();
			_bg.makeGraphic(100, 100, 0x66554400);
			add(_bg);
			
			
			_titleField = new FlxText(0, 0, 100, "test");
			add(_titleField);
			
			var pause:PauseState = new PauseState();
			add(pause);
		}
		
		override public function update():void 
		{
			if (FlxG.mouse.justPressed() && hover(0,20,FlxG.width,FlxG.height-20))
			{
				trace("press area");
			}
			super.update();
		}
		
		public function hover(x:Number, y:Number, width:int, height:int):Boolean 
		{
			var mx:int = FlxG.mouse.screenX;
			var my:int = FlxG.mouse.screenY;
			return ( (mx > x) && (mx < x + width) ) && ( (my > y) && (my < y + height) );
		}
	}

}