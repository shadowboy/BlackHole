package com.eingzone.lbb.tiles 
{
	import com.eingzone.lbb.decales.Coin;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxTilemap;
	
	/**
	 * ...
	 * @author Andy
	 */
	public class Level1 extends FlxGroup 
	{
		[Embed(source = "../../../../../src/assets/levels/mapCSV_Level1_Sky.csv", mimeType = "application/octet-stream")] 
		public var skyCSV:Class;
		[Embed(source = "../../../../../src/assets/textures/backdrop.png")] 
		public var skyTilesPNG:Class;
		
		[Embed(source = "../../../../../src/assets/levels/mapCSV_Level1_Sky.csv", mimeType = "application/octet-stream")] 
		public var treesCSV:Class;
		[Embed(source = "../../../../../src/assets/textures/tiles/medium_view.png")] 
		public var treeTilesPNG:Class;
		
		[Embed(source = "../../../../../src/assets/levels/mapCSV_Level1_Map.csv", mimeType = "application/octet-stream")] 
		public var mapCVS:Class;
		[Embed(source = "../../../../../src/assets/textures/tiles.png")] 
		public var mapTilesPNG:Class;
		
		[Embed(source = "../../../../../src/assets/levels/mapCSV_Level1_Star.csv", mimeType = "application/octet-stream")] 
		public var starsCVS:Class;
		[Embed(source = "../../../../../src/assets/textures/decales/star.png")] 
		public var starPNG:Class;
		
		public var width:int;
		public var height:int;
		
		private var _skyMap:FlxTilemap
		private var _treeMap:FlxTilemap;
		private var _map:FlxTilemap;
		private var _starMap:FlxTilemap;
		
		private var _stars:FlxGroup;
		
		/**
		 * 
		 */
		public function Level1() 
		{
			_skyMap = new FlxTilemap();
			_skyMap.loadMap(new skyCSV, skyTilesPNG, 192, 336);
			_skyMap.setTileProperties(1, FlxObject.NONE);
			_skyMap.scrollFactor.x = 0.9;
			
			_treeMap = new FlxTilemap();
			_treeMap.loadMap(new treesCSV, treeTilesPNG, 192, 336);
			_treeMap.setTileProperties(1, FlxObject.NONE);
			_treeMap.scrollFactor.x = 0.6;
			
			_map = new FlxTilemap();
			_map.loadMap(new mapCVS, mapTilesPNG, 16, 16);
			//设置不需要碰撞的Tile
			_map.setTileProperties(13,FlxObject.NONE);
			_map.setTileProperties(14,FlxObject.NONE);
			_map.setTileProperties(16,FlxObject.NONE);
			_map.setTileProperties(17, FlxObject.NONE);

			
			add(_skyMap);
			add(_treeMap);
			add(_map);
			
			parseEnemies();
		}
		
		private function parseEnemies():void
		{
			_starMap = new FlxTilemap();
			_starMap.loadMap(new starsCVS, starPNG, 16, 16);
			
			_stars = new FlxGroup();
			for (var i:int = 0; i < _starMap.widthInTiles; i++)
			{
				for (var j:int = 0; j < _starMap.heightInTiles; j++)
				{
					if (_starMap.getTile(i, j) == 1)
					{
						var coin:Coin = new Coin();
						coin.showCoin(i * 16, j * 16);
						_stars.add(coin);
					}
				}
			}
		}
		
	}

}