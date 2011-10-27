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
		[Embed(source = "../../assets/levels/mapCSV_Level1_Sky.csv", mimeType = "application/octet-stream")] 
		public var skyCSV:Class;
		[Embed(source = "../../assets/textures/tiles/backdrop.png")] 
		public var skyTilesPNG:Class;
		
		[Embed(source = "../../assets/levels/mapCSV_Level1_Tree.csv", mimeType = "application/octet-stream")] 
		public var treesCSV:Class;
		[Embed(source = "../../assets/textures/tiles/trees.png")] 
		public var treeTilesPNG:Class;
		
		[Embed(source = "../../assets/levels/mapCSV_Level1_Map.csv", mimeType = "application/octet-stream")] 
		public var mapCVS:Class;
		[Embed(source = "../../assets/textures/tiles/tiles.png")] 
		public var mapTilesPNG:Class;
		
		[Embed(source = "../../assets/levels/mapCSV_Level1_Star.csv", mimeType = "application/octet-stream")] 
		public var starsCVS:Class;
		[Embed(source = "../../assets/textures/decales/star.png")] 
		public var starPNG:Class;
		
		//tile maps
		private var _skyMap:FlxTilemap
		private var _treeMap:FlxTilemap;
		private var _map:FlxTilemap;
		private var _starMap:FlxTilemap;
		//starts
		private var _stars:FlxGroup;
		//properties
		private var _width:int;
		private var _height:int;
		private var _x:int;
		private var _y:int;
		
		/**
		 * construction
		 */
		public function LevelBase() 
		{
			_skyMap = new FlxTilemap();
			_skyMap.loadMap(new skyCSV, skyTilesPNG, 192, 336);
			_skyMap.setTileProperties(1, FlxObject.NONE);
			_skyMap.scrollFactor.x = 0.1;
			_skyMap.scrollFactor.y = 0.1;
			add(_skyMap);
			
			_treeMap = new FlxTilemap();
			_treeMap.loadMap(new treesCSV, treeTilesPNG, 192, 336);
			_treeMap.setTileProperties(1, FlxObject.NONE);
			_treeMap.scrollFactor.x = 0.5;
			_treeMap.scrollFactor.y = 0.3;
			add(_treeMap);
			
			_map = new FlxTilemap();
			_map.loadMap(new mapCVS, mapTilesPNG, 16, 16);
			//set something property
			_map.setTileProperties(13,FlxObject.NONE);
			_map.setTileProperties(14,FlxObject.NONE);
			_map.setTileProperties(16,FlxObject.NONE);
			_map.setTileProperties(17, FlxObject.NONE);
			_map.setTileProperties(58, FlxObject.NONE);
			_map.setTileProperties(77, FlxObject.NONE);
			add(_map);
			
			//conins
			parseStars();
			add(_stars);
		}
		
		public function get width():int 
		{
			return _map.width;
		}
		
		public function get height():int 
		{
			return _map.height;
		}
		
		public function get x():int 
		{
			return _x;
		}
		
		public function set x(value:int):void 
		{
			_x = value;
			_map.x = value;
			_skyMap.x = value;
			_treeMap.x = value;
		}
		
		public function get y():int 
		{
			return _y;
		}
		
		public function set y(value:int):void 
		{
			_y = value;
			_map.y = value;
			_skyMap.y = value;
			_treeMap.y = value;
		}
		
		
		/**
		 * parse stars
		 */
		private function parseStars():void
		{
			_starMap = new FlxTilemap();
			_starMap.loadMap(new starsCVS, starPNG, 16, 16);
			
			_stars = new FlxGroup();
			for (var i:int = 0; i < _starMap.widthInTiles; i++)
			{
				for (var j:int = 0; j < _starMap.heightInTiles; j++)
				{
					var index:int = _starMap.getTile(i, j);
					trace(this + "star:" + index);
					if (index == 1)
					{
						var coin:Coin = new Coin();
						coin.showCoin(i * 16, j * 16);
						_stars.add(coin);
					}
					else if (index == 2)
					{
						var rCoin:RocketCoin = new RocketCoin(i * 16, j * 16);
						_stars.add(rCoin);
					}
				}
			}
		}
	}
}