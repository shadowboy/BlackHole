package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	//import flash.display.StageAspectRatio;
	//import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	
	import game.MenuState;
	import game.test.TestEnemies;
	import game.test.state.TestPlayerState;
	import game.utils.Environment;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGame;

	/**
	* This is the interface of game
    * 
	* @Author Andy Cao
	*/
	[SWF(width="480", height="320", backgroundColor="#ffffff" , frameRate="60")]
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
				w = 240;
				h = 160;
				scale = 2;
                
                //w = 512;
                //h = 384;
                //scale = 2;
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
					w = 512;
					h = 384;
					scale = 2;
				}
			}
            
            
			super(w, h, TestEnemies, scale);
            FlxG.bgColor = 0xffffffff;
			FlxG.mouse.show();
			FlxG.debug = true;
			FlxG.framerate = 60;
		}
	}
}