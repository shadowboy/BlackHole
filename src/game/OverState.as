package game
{
	
	import game.utils.Layout;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Andy
	 */
	public class OverState extends FlxState 
	{
        [Embed(source="../assets/textures/ui/bg_faile.png")]
        private var bgPNG:Class;
        
        [Embed(source="../assets/textures/ui/btn_retry.png")]
        private var retryBtnPNG:Class;
        
        [Embed(source="../assets/textures/ui/btn_back.png")]
        private var backBtnPNG:Class;
        
        [Embed(source="../assets/audio/faile.mp3")]
        private var faileSound:Class;
        
		//胜利画面的等待时间计数
		private var _time:Number;
		private var _backBtn:FlxButton;
		private var _retryBtn:FlxButton;
		
		override public function create():void 
		{
            var bg:FlxSprite = new FlxSprite();
            bg.loadGraphic(bgPNG);
            Layout.center(bg);
            add(bg);
            
			_time = 0;
			FlxG.flash(0xffffffff, 1);
			var t:FlxText = new FlxText(0, 0, 100, 'GAME OVER');
            t.setFormat(null,12,0x00000000,"center",0xcccccc);
			t.x = (FlxG.width - t.width)/2;
			t.y = int(FlxG.height/5);
			add(t);
            
            var score:FlxText = new FlxText(0, 0, 200, 'SCORE:0');
            score.setFormat(null,12,0x00000000,"center",0xcccccc);
            score.x = (FlxG.width - score.width)/2;
            score.y = int(FlxG.height/5)+t.height;
            score.text = "The Score:"+FlxG.score;
            add(score);
			
			_retryBtn = new FlxButton();
            _retryBtn.loadGraphic(retryBtnPNG,false,false,70,40);
            _retryBtn.onDown = retryHandler;
			_retryBtn.x = (FlxG.width - _retryBtn.width)/2;
			_retryBtn.y = FlxG.height*0.5-20;
			add(_retryBtn);
			
			_backBtn = new FlxButton();
            _backBtn.loadGraphic(backBtnPNG,false,false,70,40);
            _backBtn.onDown = backHandler;
			_backBtn.x = (FlxG.width - _backBtn.width)/2;
			_backBtn.y = FlxG.height*0.5+20;
			add(_backBtn);
            
            FlxG.play(faileSound,1,false,false);
		}
		
		private function retryHandler():void
		{
			FlxG.fade(0xffffffff, 1, goGamePlayState);
		}
		
		private function goGamePlayState():void
		{
			// TODO Auto Generated method stub
			FlxG.switchState(new PlayState());
		}
		
		private function backHandler():void
		{
			FlxG.fade(0xffffffff, 1, goMenuStatus);
		}
		
		private function goMenuStatus():void
		{
			FlxG.switchState(new MenuState());
		}
	}
	
}