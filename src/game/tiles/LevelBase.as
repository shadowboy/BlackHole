package game.tiles 
{
	import game.decales.Coin;
	import game.decales.RocketCoin;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxTilemap;
	
	/**
	 * ...
	 * @author Andy
	 */
	public class LevelBase extends FlxGroup 
	{
		
		private var _skyMap:FlxTilemap
		private var _treeMap:FlxTilemap;
		private var _map:FlxTilemap;
		private var _starMap:FlxTilemap;
		
		protected var _stars:FlxGroup;
		protected var _tilemap:FlxTilemap;
		
		/**
		 * 
		 */
		public function LevelBase() 
		{
		}
		
		public function get width():int 
		{
			return _tilemap.width;
		}
		
		public function get height():int 
		{
			return _tilemap.height;
		}
	}
}