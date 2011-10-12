package game
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Andy
	 */
	public class OptionState extends BaseOtherState 
	{

		
		[Embed(source="../assets/textures/ui/4345441923_305fbde3a7.jpg")]
		private var bgClass:Class;
		
		public function OptionState() 
		{
			super("I'm about~",bgClass);
		}
	}
}