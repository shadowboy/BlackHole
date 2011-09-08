package  
{
	import org.flixel.FlxButton;
	import org.flixel.system.FlxPreloader;
	
	/**
	 * ...
	 * @author Andy Cao
	 */
	public class Preloader extends FlxPreloader 
	{
		public function Preloader() 
		{
			super();
			this.className = "Main";
			this.myURL = "http://www.f1982.com";
			this.minDisplayTime = 3
		}
	}
}