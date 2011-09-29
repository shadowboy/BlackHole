package com.eingzone.lbb.ui
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class MenuState extends FlxState 
	{
		private var _playBtn:FlxButton;
		private var _optionBtn:FlxButton;
		private var _aboutBtn:FlxButton;
		private var _helpBtn:FlxButton;
		
		public function MenuState() 
		{
			FlxG.mouse.show();
			
			var cx:int = (FlxG.width-80)/2;
			var sy:int = 120;
			
			_playBtn = new FlxButton(0, 0, "play", playHandler);
			_playBtn.x = cx;
			_playBtn.y = sy;
			add(_playBtn);
			
			sy+= 25;
			
			_optionBtn = new FlxButton(0, 0, "option", optionHandler);
			_optionBtn.x = cx;
			_optionBtn.y = sy;
			add(_optionBtn);
			
			sy+= 25;
			
			_aboutBtn = new FlxButton(0, 0, "about", aboutHandler);
			_aboutBtn.x = cx;
			_aboutBtn.y = sy;
			add(_aboutBtn);
			
			sy+= 25;
			
			_helpBtn = new FlxButton(100, 160, "help", helpHandler);
			_helpBtn.x = cx;
			_helpBtn.y = sy;
			add(_helpBtn);
			
			test();
		}
		
		private function playHandler():void 
		{
			FlxG.switchState(new GameState);
		}
		
		private function helpHandler():void 
		{
			FlxG.switchState(new HelpState);
		}
		
		private function aboutHandler():void 
		{
			FlxG.switchState(new AboutState);
		}
		
		private function optionHandler():void 
		{
			FlxG.switchState(new OptionState);
		}
		
		private function test():void
		{
			
		}
	}
}