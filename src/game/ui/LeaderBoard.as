package game.ui 
{
	import org.flixel.FlxGroup;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class LeaderBoard extends FlxGroup 
	{
		private var _data:Array;
		
		public function LeaderBoard() 
		{
			
		}
		
		public function set data(value:Array):void 
		{
			_data = value;
			createItems();
		}
		
		private function createItems():void 
		{
			for (var i:int = 0; i < 8; i++) 
			{
				var item:LeaderBoardItem = new LeaderBoardItem();
				
				item.name = "Andy";
				item.score = 230;
				item.y = 30*i;
				add(item);
			}
		}
		
	}

}