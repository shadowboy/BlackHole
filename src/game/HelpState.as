package game
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class HelpState extends BaseOtherState 
	{
		[Embed(source="../assets/textures/ui/bg_help.png")]
		private var bgClass:Class;
		
		public function HelpState() 
		{
			super("Help", bgClass);
		}
	}
}