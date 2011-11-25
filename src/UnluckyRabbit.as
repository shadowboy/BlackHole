package
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import game.MenuState;
	import game.test.TestEmitterLikeBlood;
	import game.utils.Environment;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	
	[SWF(width="960",height="640",backgroundColor="#000000",frameRate="60")]
	
	//[Frame(factoryClass="Preloader")]
	
	/**
	 * This is the interface of game
	 *
	 * @author Andy Cao
	 */
	public class UnluckyRabbit extends FlxGame
	{
		public function UnluckyRabbit()
		{
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//stage.setAspectRatio(StageAspectRatio.LANDSCAPE);
			//stage.setOrientation(StageOrientation.ROTATED_RIGHT);
			//stage.autoOrients = false;
			
			var w:int = 240;
			var h:int = 160;
			var scale:int = 2
			var env:Environment = Environment.getInstance();
			if (env.showType == Environment.WINDOW_TYPE)
			{
				w = 960;
				h = 640;
				scale = 1;
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
			}
			super(w, h, MenuState, scale);
			FlxG.debug = true;
			FlxG.framerate = 30;
		}
	}
}