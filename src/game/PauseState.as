package game
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class PauseState extends FlxGroup 
	{
		[Embed(source="../assets/textures/ui/4345441923_305fbde3a7.jpg")]
		private var bgClass:Class;
		
		protected var _bg:FlxSprite;
		
		protected var _titleField:FlxText;
		protected var _introField:FlxText;
		protected var _resumeBtn:FlxButton;
		protected var _backBtn:FlxButton;
		
		public function PauseState() 
		{
			super();

			_bg = new FlxSprite();
			//trace(FlxG.width, FlxG.height);
			_bg.makeGraphic(FlxG.width, FlxG.height, 0xffcc0000);
			add(_bg);
			
			_titleField = new FlxText(0, 0, 100, "Pause");
			_titleField.x = (FlxG.width - _titleField.width) / 2;
			_titleField.y = 30;
			//add(_titleField);
			
			var sy:int = FlxG.height / 2;
			_resumeBtn = new FlxButton(0, 0, "Resume", backHandler);
			_resumeBtn.x = int((FlxG.width - _resumeBtn.width) / 2);
			_resumeBtn.y = sy;
			//add(_resumeBtn);
			
			sy += _resumeBtn.height+10;
			_backBtn = new FlxButton(0, 0, "back", backHandler);
			_backBtn.x = int((FlxG.width - _backBtn.width) / 2);
			_backBtn.y = sy
			//add(_backBtn);
		}
		
		private function backHandler():void 
		{
			FlxG.switchState(new MenuState());
		}
		
	}

}