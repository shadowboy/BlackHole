package
{
	import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	import game.MenuState;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxGame;
	import org.flixel.FlxSprite;
	import org.flixel.system.debug.Log;

	/**
	* this is the interface of game
	* @author Andy Cao
	*/
	[SWF(width="960", height="640", backgroundColor="#000000")]
	//[Frame(factoryClass="Preloader")]
	public class UnluckyRabbit extends FlxGame
	{
		public function UnluckyRabbit()
		{
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			
			//横屏模式
			
			stage.setAspectRatio(StageAspectRatio.LANDSCAPE);
			stage.setOrientation(StageOrientation.ROTATED_LEFT );
			stage.autoOrients = true;
			
			super(480,320,MenuState,2);
		}
	}
}