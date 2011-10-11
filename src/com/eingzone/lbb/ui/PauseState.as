package com.eingzone.lbb.ui
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
		[Embed(source="../../../../../src/assets/textures/ui/4345441923_305fbde3a7.jpg")]
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
			_bg.loadGraphic(bgClass, false, false, FlxG.width, FlxG.height);
			add(_bg);
			
			_titleField = new FlxText(0, 0, 100, "Pause");
			add(_titleField);
			
			_resumeBtn = new FlxButton(FlxG.width-200, 40, "Resume", backHandler);
			add(_resumeBtn);
			
			_backBtn = new FlxButton(FlxG.width-200, 80, "back", backHandler);
			add(_backBtn);
		}
		
		private function backHandler():void 
		{
			FlxG.switchState(new MenuState());
		}
		
	}

}