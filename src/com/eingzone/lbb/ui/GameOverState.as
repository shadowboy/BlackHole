package com.eingzone.lbb.ui
{
	import com.eingzone.lbb.ui.GameState;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Andy
	 */
	public class GameOverState extends FlxState 
	{
		//胜利画面的等待时间计数
		private var _time:Number;
		override public function create():void 
		{
			_time = 0;
			FlxG.flash(0xffffffff, 1);
			add(new FlxText(100, 50, 100, 'GAME OVER'));
		}
		
		override public function update():void 
		{
			_time += FlxG.elapsed;
			if (_time>5) 
			{
				FlxG.fade(0xffffffff, 1, onPlay);
			}
			super.update();
		}
		
		private function onPlay():void
		{
			FlxG.switchState(new MenuState());
		}
	}
	
}