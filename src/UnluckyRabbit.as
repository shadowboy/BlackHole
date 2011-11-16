package
{
	import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import game.PlayState;
	import game.test.TestEmitter;
	import game.test.TestEmitter2;
	import game.utils.Environment;
	
	import game.MenuState;
	import game.test.Test;
	import game.test.TestAutoBuildMap;
	import game.test.TestLeaderBoard;
	
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
			
			var w:int = 240;
			var h:int = 160;
			var scale:int = 2
			var env:Environment = Environment.getInstance();
			if (env.showType == Environment.WINDOW_TYPE)
			{
				w = 240;
				h = 160;
				scale = 2;
			}
			else
			{
				if (env.device == Environment.IPHONE)
				{
					w = 240;
					h = 160;
					scale = 2;
				}
				else if (env.device == Environment.IPHONE_RETINA)
				{
					w = 240;
					h = 160;
					scale = 4;
				}
				else if (env.device == Environment.IPAD)
				{
					w = 256;
					h = 192;
					scale = 4;
				}
				//flash.system.Capabilities.version.indexOf(“IOS”) == 0 
				//(Android returns “AND” and 
				//BlackBerry Tablet OS returns “QNX”).
			}
			
			super(w, h, MenuState, scale);
		}
	}
}