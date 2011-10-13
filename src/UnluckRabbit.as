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
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class UnluckRabbit extends FlxGame
	{
		public function UnluckRabbit()
		{
			super(320,240,MenuState,2);
		}
	}
}