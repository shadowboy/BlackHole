package game.test
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.PauseState;
	import game.Resource;
	import game.tiles.LandAbstract;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class TestAutoBuildMap extends FlxState 
	{
		
		[Embed(source = "../../assets/textures/tiles/tiles.png")] 
		public var mapTilesPNG:Class;
		
		[Embed(source = "../../assets/textures/actors/little_alien.gif")] 
		public var alienPNG:Class;
		
		[Embed(source = "auto_build_map.txt", mimeType = "application/octet-stream")] 
		public var mapCSV:Class;
		
		protected var _player:FlxSprite;
		protected var _tilemap:FlxTilemap;
		protected var _bgFlx:FlxSprite;
		
		protected var _titleField:FlxText;
		protected var _introField:FlxText;
		protected var _backBtn:FlxButton;
		
		protected var _tileList:FlxGroup;
		protected var _curTileIndex:int = 0;
		private var _curTile:*;
		
		protected var _preTile:*;
		
		public function TestAutoBuildMap() 
		{
			super();
			Resource.init();
			_player = new FlxSprite();
			_player.x = 0;
			_player.alpha = 0.2;
			_player.loadGraphic(alienPNG, false, false, 16, 16);
			add(_player);
			//
			_tilemap = new FlxTilemap();
			_tilemap.loadMap(new mapCSV, mapTilesPNG, 16, 16);

			//
			var tm2:FlxTilemap = new FlxTilemap();
			tm2.loadMap(new mapCSV, mapTilesPNG, 16, 16);
			//tm2.setTile(2, 2, 4);
			
			var tm3:FlxTilemap = new FlxTilemap();
			tm3.loadMap(new mapCSV, mapTilesPNG, 16, 16);
			//tm3.setTile(2, 2, 4);
			
			var tm4:FlxTilemap = new FlxTilemap();
			tm4.loadMap(new mapCSV, mapTilesPNG, 16, 16);
			
			_tileList = new FlxGroup();
			
			_tileList.add(_tilemap);
			_tileList.add(tm2);
			_tileList.add(tm4);
			_tileList.add(tm3);
			
			

			_curTile = _tileList.members[_curTileIndex]
            _preTile = _curTile;
			add(_curTile);
		}
		
		private function getTile():*
		{
			trace(_curTileIndex);
			if (_curTileIndex >= _tileList.length-1)
			{
				_curTileIndex = 0;
			}
			else
			{
				_curTileIndex++;
			}
			return _tileList.members[_curTileIndex];
		}
		
		override public function update():void 
		{
			FlxG.camera.follow(_player);
			_player.velocity.x = 200;
			
			if (_curTile.x + _curTile.width - _player.x<FlxG.width) 
            {
				//trace("add new item to screen");
				_preTile = _curTile;
				
				_curTile = getTile();
				_curTile.x = _preTile.x + _preTile.width;
				try
				{
					_curTile.init();
                    add(_curTile.stars);
                    add(_curTile.enemies);
				}
				catch (e:Error) 
				{
					trace("no init function");
				}
				trace("_curTile:"+_curTile)
				
				add(_curTile);
			}
			
			if (_curTileIndex>2 && _tileList.members[_curTileIndex-2]!=null)
			{
				trace("remove current item screen");
				//remove(_tileList.members[_curTileIndex - 2]);
				//_tileList.members[_curTileIndex - 2] = null
				
			}
			super.update();
		}
	}
}