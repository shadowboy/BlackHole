package game
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
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
		
        [Embed(source="../assets/textures/ui/btn_resume.png")]
        private var btnResumeClass:Class;
        
		protected var _bg:FlxSprite;
		
		protected var _titleField:FlxText;
		protected var _introField:FlxText;
		protected var _resumeBtn:FlxButton;
		protected var _backBtn:FlxButton;
		protected var _resumeCallback:Function;
		
		public function PauseState() 
		{
			super();

			_bg = new FlxSprite();
			_bg.makeGraphic(FlxG.width, FlxG.height, 0x0);
            _bg.alpha = 0.3;
			_bg.scrollFactor = new FlxPoint(0, 0);
			add(_bg);
			
			_titleField = new FlxText(0, 0, 100, "Paused");
			_titleField.x = (FlxG.width - _titleField.width) / 2;
			_titleField.scrollFactor = new FlxPoint(0, 0);
			_titleField.y = 30;
			add(_titleField);
			
			var sy:int = FlxG.height / 2;
			_resumeBtn = new FlxButton();
            _resumeBtn.loadGraphic(btnResumeClass,false,false,50,80);
			_resumeBtn.scrollFactor = new FlxPoint(0, 0);
			_resumeBtn.x = int(FlxG.width/3*2);
			_resumeBtn.y = FlxG.height - _resumeBtn.height;
            _resumeBtn.onDown = resumeHandler;
			add(_resumeBtn);
			
			sy += _resumeBtn.height+10;
			_backBtn = new FlxButton(0, 0, "back", backHandler);
			_backBtn.scrollFactor = new FlxPoint(0, 0);
			_backBtn.x = int((FlxG.width - _backBtn.width) / 2);
			_backBtn.y = sy
			add(_backBtn);
		}
		
		
		public function set enabled(value:Boolean):void 
		{
			_backBtn.visible = value;
			_resumeBtn.visible = value;
			this.visible = value;
		}
		
		private function resumeHandler():void 
		{
			if (_resumeCallback != null)
			{
				_resumeCallback();
			}
		}
		
		private function backHandler():void 
		{
			FlxG.switchState(new MenuState());
		}
		
		public function set resumeCallback(value:Function):void 
		{
			_resumeCallback = value;
		}
		
		
	}

}