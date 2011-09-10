package  
{
	import com.eingzone.lbb.ui.MenuState;
	
	import org.flixel.FlxGame;

	/**
	 * ...
	 * @author Andy Cao
	 */
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class Main extends FlxGame 
	{
		public function Main() 
		{
			super(320,240,MenuState,2);
			trace("start");
		}
		
	}
	
}
