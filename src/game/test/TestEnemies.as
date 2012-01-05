package game.test
{
	import game.projectiles.Bullet;
	import game.Resource;
	import game.actors.Enemy;
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	
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
	public class TestEnemies extends FlxState 
	{
		
		
		[Embed(source = "../../assets/textures/tiles/tiles.png")] 
		public var mapTilesPNG:Class;
		
		[Embed(source = "../../assets/textures/actors/little_alien.gif")] 
		public var alienPNG:Class;
		
		[Embed(source = "auto_build_map.txt", mimeType = "application/octet-stream")] 
		public var mapCSV:Class;
		
		protected var _enemy:Enemy;
		
		private var _tiles:FlxGroup;
		protected var _tilemap:FlxTilemap;
		
		public function TestEnemies() 
		{
			super();
            
			Resource.init();
			
			_tiles = new FlxGroup();
			this.add(_tiles);
			
			_enemy = new Enemy(220,180);
			add(_enemy);
			//
			_tilemap = new FlxTilemap();
			_tilemap.loadMap(new mapCSV, mapTilesPNG, 16, 16);
            _tilemap.x = 100;
            _tilemap.y = 0;
			_tilemap.allowCollisions = FlxObject.UP;
			_tiles.add(_tilemap);
            
            _enemy.map = _tilemap;
		}
		

		override public function update():void 
		{
			FlxG.worldBounds = new FlxRect((FlxG.camera.scroll.x), (FlxG.camera.scroll.y), FlxG.camera.width*2, FlxG.camera.height);
			FlxG.camera.follow(_enemy);
			//FlxG.collide(_tilemap, _enemy, enemyCollideTilemap);
			FlxG.collide(_tiles, _enemy);
			trace("update");
			super.update();
			
		}
		
		private function enemyCollideTilemap(obj1:Object,obj2:Object):void 
		{
			trace(obj1, obj2);
		}
	}
}