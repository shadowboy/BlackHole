package
{
	import game.MenuState;

	import org.flixel.FlxGame;
	import org.flixel.system.debug.Log;
	import flash.geom.Rectangle;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxSprite;

	/**
	* this is the interface of game
	* @author Andy Cao
	*/
	[SWF(width="480", height="320", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class UnluckyRabbit extends FlxGame
	{
		public function UnluckyRabbit()
		{
			super(240,160,MenuState,2);
		}
	}
}