package game
{
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Andy
	 */
	public class OverState extends FlxState 
	{
		//胜利画面的等待时间计数
		private var _time:Number;
		private var _backBtn:FlxButton;
		private var _retryBtn:FlxButton;
		
		override public function create():void 
		{
			_time = 0;
			FlxG.flash(0xffffffff, 1);
			var t:FlxText = new FlxText(0, 0, 100, 'GAME OVER');
			t.x = (FlxG.width - t.width)/2;
			t.y = int(FlxG.height/5*2);
			add(t);
			
			_retryBtn = new FlxButton(0, 0, "retry", retryHandler);
			_retryBtn.x = (FlxG.width - _retryBtn.width)/2;
			_retryBtn.y = FlxG.height*0.5;
			add(_retryBtn);
			
			_backBtn = new FlxButton(0, 0, "back", backHandler);
			_backBtn.x = (FlxG.width - _backBtn.width)/2;
			_backBtn.y = FlxG.height*0.5+30;
			add(_backBtn);
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