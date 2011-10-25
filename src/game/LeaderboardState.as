package game
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class LeaderboardState extends BaseOtherState 
	{
		[Embed(source="../assets/textures/ui/bg_leaderboard.png")]
		private var bgClass:Class;
		
		public function LeaderboardState() 
		{
			super("Help", bgClass);
		}
	}
}