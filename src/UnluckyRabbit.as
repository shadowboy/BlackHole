package
{
	import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import game.MenuState;
	import game.test.Test;
	import game.test.TestAutoBuildMap;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
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
			//stage.setAspectRatio(StageAspectRatio.LANDSCAPE);
			//stage.setOrientation(StageOrientation.ROTATED_RIGHT);
			//stage.autoOrients = false;

			var scale:int;
			var w:int;
			var h:int;
			if(Capabilities.screenDPI>300)
			{
				scale = 4;
				w = 240;
				h = 160;
			}
			else
			{
				scale = 2;
				w = 240;
				h = 160;
			}
            //for ipad
			//super(256,192,MenuState,4);
			super(240,160,MenuState,2);
//            super(960,640,TestAutoBuildMap,1);
		}
	}
}