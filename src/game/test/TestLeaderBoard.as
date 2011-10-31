package game.test
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.LeaderboardState;
	import game.ui.LeaderBoardItem;
	
	import game.PauseState;
	import game.Registry;
	import game.Resource;
	import game.decales.Coin;
	import game.tiles.LevelBase;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class TestLeaderBoard extends FlxState 
	{
		private var _stars:FlxGroup;
		protected var _bg:FlxSprite;
		protected var _bgFlx:FlxSprite;
		
		protected var _titleField:FlxText;
		protected var _introField:FlxText;
		protected var _backBtn:FlxButton;
		
		public function TestLeaderBoard() 
		{
			super();
			FlxG.mouse.show();
			
			var list:LeaderboardState = new LeaderboardState();
			list.data = [{name:"Andy",score:100},{name:"Andy",score:100},{name:"Andy",score:100},{name:"Andy",score:100},{name:"Andy",score:100}]
			add(list);
			
			
		}
		
		private function testItem():void
		{
			var item:LeaderBoardItem = new LeaderBoardItem();
			item.name = "Andy";
			item.score = 123;
			add(item);
		}
		
	}

}