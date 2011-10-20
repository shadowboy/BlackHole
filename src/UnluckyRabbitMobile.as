package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	
	import game.*;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import org.flixel.system.debug.Log;
	
	[SWF(width='480', height='320', backgroundColor='#000000', frameRate='30')]
	//[Frame(factoryClass="Preloader")]
	public class UnluckyRabbitMobile extends FlxGame
	{
		public function UnluckyRabbitMobile()
		{
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//横屏模式
			stage.setAspectRatio(StageAspectRatio.LANDSCAPE);
			stage.setOrientation(StageOrientation.ROTATED_LEFT );
			stage.autoOrients = false;
			
			super(240,160,MenuState,2);
			FlxG.debug = false;
		}
	}
}