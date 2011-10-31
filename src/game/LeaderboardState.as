package game
{
	import game.ui.LeaderBoardItem;
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
		
		private var _data:Array;
		
		public function LeaderboardState() 
		{
			super("Help", bgClass);
			
			
		}
		
		public function set data(value:Array):void 
		{
			_data = value;
			createItems();
		}
		
		private function createItems():void 
		{
			var sy:int = 20;
			for (var i:int = 0; i < 3; i++) 
			{
				var obj:Object = _data[i];
				var item:LeaderBoardItem = new LeaderBoardItem();
				item.name = obj.name;
				item.score = obj.score;
				item.x = 60;
				item.y = sy + 30 * i;
				add(item);
			}
		}
	}
}