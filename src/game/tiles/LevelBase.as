package game.tiles 
{
	import game.actors.Enemy;
	import game.Registry;
	import game.decales.Coin;
	import game.decales.RocketCoin;
	import game.Resource;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	
	/**
	 * ...
	 * @author Andy
	 */
	public class LevelBase extends FlxGroup 
	{
		[Embed(source = "../../assets/levels/mapCSV_Level1_Map.csv", mimeType = "application/octet-stream")] 
		public var mapCVS:Class;
		[Embed(source = "../../assets/textures/tiles/tiles.png")] 
		public var mapTilesPNG:Class;
		
		[Embed(source = "../../assets/levels/mapCSV_Level1_Star.csv", mimeType = "application/octet-stream")] 
		public var starsCVS:Class;
		[Embed(source = "../../assets/textures/decales/star.png")] 
		public var starPNG:Class;
		
		private var _map:FlxTilemap;
		private var _starMap:FlxTilemap;
        
		protected var _stars:FlxGroup;
		protected var _tilemap:FlxTilemap;
		
		protected var _enemy:Enemy;
		
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
			return _map.x;
		}
		
		public function set x(value:int):void 
		{
			_x = value;
			_map.x = _x;
		}
		
		public function get y():int 
		{
			return _map.y;
		}
		
		public function set y(value:int):void 
		{
			_y = value;
			_map.y = value;
		}
		
		public function get stars():FlxGroup 
		{
			return _stars;
		}
		
		public function init():void
		{
			parseStars();
			
			_enemy = new Enemy(_map.x + 100, _map.y + 60);
			add(_enemy);
		}
		
		/**
		 * parse stars
		 */
		private function parseStars():void
		{
			_starMap = new FlxTilemap();
			_starMap.loadMap(new starsCVS, starPNG, 16, 16);
			
			
			for (var i:int = 0; i < _starMap.widthInTiles; i++)
			{
				for (var j:int = 0; j < _starMap.heightInTiles; j++)
				{
					var index:int = _starMap.getTile(i, j);
					
					if (index == 1)
					{
                        trace(this + " star:" + index+" x:"+_map.x+i*16+" y:"+_map.y+j*16);
						var coin:Coin = Resource.getCoin() as Coin;
						coin.showCoin(_map.x + i * 16, _map.y + j * 16);
						add(coin);
					}
				}
			}
		}
	}
}