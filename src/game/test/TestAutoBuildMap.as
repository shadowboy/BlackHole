package game.test
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.PauseState;
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
		protected var _curInx:int = 0;
		private var _curItem:FlxTilemap;
		
		protected var _preItem:FlxTilemap;
		
		public function TestAutoBuildMap() 
		{
			super();
			
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
			
			_tileList = new FlxGroup();
			_tileList.add(_tilemap);
			_tileList.add(tm2);
			_tileList.add(tm3);
			
			_curItem = _tileList.members[_curInx]
			add(_curItem);
		}
		
		private function getTile():FlxTilemap
		{
			trace(_curInx);
			if (_curInx >= _tileList.length-1)
			{
				_curInx = 0;
			}
			else
			{
				_curInx++;
			}
			return _tileList.members[_curInx] as FlxTilemap;
		}
		
		override public function update():void 
		{
			FlxG.camera.follow(_player);
			_player.velocity.x = 200;
			//trace(_player.x);
			//
			//trace("camera x:" + FlxG.camera.x);
			//trace("tilemap x:" + _tilemap.x);
			
			if (_curItem.x + _curItem.width - _player.x<FlxG.width) {
				//trace("add new item to screen");
				_preItem = _curItem;
				
				_curItem = getTile();
				_curItem.x = _preItem.x + _preItem.width;
				add(_curItem);
			}
			
			
			if (_preItem)
			{
				//trace("play and tile:"+(_player.x - _preItem.x)+" pre width:"+_preItem.width);
				if (_player.x - _preItem.x > _preItem.width+120)
				{
					remove(_preItem);
					_preItem = null;
					trace("remove current item screen");
				}
				
			}
			super.update();
		}
	}
}