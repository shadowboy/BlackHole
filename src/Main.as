package  
{
	import com.eingzone.lbb.ui.MenuState;
	
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
	public class Main extends FlxGame 
	{
		public function Main() 
		{
			super(320,240,MenuState,2);
		}
	}
}
