package game.tiles 
{
	import game.decales.Coin;
	import game.decales.RocketCoin;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTile;
	
	/**
	 * ...
	 * @author Andy
	 */
	public class TileManager extends FlxGroup 
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
        [Embed(source = "../../assets/levels/mapCSV_Level1_Map2.csv", mimeType = "application/octet-stream")] 
        public var map2CVS:Class;
		[Embed(source = "../../assets/textures/tiles/tiles.png")] 
		public var mapTilesPNG:Class;
		
		[Embed(source = "../../assets/levels/mapCSV_Level1_Star.csv", mimeType = "application/octet-stream")] 
		public var starsCVS:Class;
		[Embed(source = "../../assets/textures/decales/star.png")] 
		public var starPNG:Class;
		
		public var width:int;
		public var height:int;
		
		private var _skyMap:FlxTilemap
		private var _treeMap:FlxTilemap;
		private var _map:FlxTilemap;
		private var _starMap:FlxTilemap;
		
		private var _stars:FlxGroup;
        
		private var _curIndex:int;
		private var _tileList:FlxGroup;
		
		/**
		 * 
		 */
		public function TileManager() 
		{
			_skyMap = new FlxTilemap();
			_skyMap.loadMap(new skyCSV, skyTilesPNG, 192, 336);
			_skyMap.setTileProperties(1, FlxObject.NONE);
			_skyMap.scrollFactor.x = 0.1;
			_skyMap.scrollFactor.y = 0.1;
			
			_treeMap = new FlxTilemap();
			_treeMap.loadMap(new treesCSV, treeTilesPNG, 192, 336);
			_treeMap.setTileProperties(1, FlxObject.NONE);
			_treeMap.scrollFactor.x = 0.5;
			_treeMap.scrollFactor.y = 0.3;
            
            _tileList = new FlxGroup();
            
            
            
            var bt:LevelBase = new LevelBase();
            var bt2:LevelBase = new LevelBase();
            var bt3:LevelBase = new LevelBase();
            
//            addTile(mapCVS);
//            addTile(map2CVS);
            _tileList.add(bt);
            _tileList.add(bt2);
            _tileList.add(bt3);
		}
        
        public function get sky():FlxTilemap 
        {
            return _skyMap;
        }
        
        public function get tree():FlxTilemap 
        {
            return _treeMap;
        }
        
        
        /**
         * add map 
         * @param MapCVS
         */        

        public function addTile(MapCVS:Class):void
        {
            var map:FlxTilemap = new FlxTilemap();
            map.loadMap(new MapCVS, mapTilesPNG, 16, 16);
            map.setTileProperties(13,FlxObject.NONE);
            map.setTileProperties(14,FlxObject.NONE);
            map.setTileProperties(16,FlxObject.NONE);
            map.setTileProperties(17, FlxObject.NONE);
            map.setTileProperties(58, FlxObject.NONE);
            map.setTileProperties(77, FlxObject.NONE);
            
            _tileList.add(map);
        }
        
        /**
         * get tiles 
         * @return 
         * 
         */        
        public function getTile():LevelBase
        {
            if (_curIndex >= _tileList.length-1)
            {
                _curIndex = 0;
            }
            else
            {
                _curIndex++;
            }
            return _tileList.members[_curIndex] as LevelBase;
        }
	}
}