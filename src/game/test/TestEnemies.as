package game.test
{
	import game.Resource;
	import game.actors.Enemy;
	
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
		protected var _tilemap:FlxTilemap;
		
		public function TestEnemies() 
		{
			super();
            
			Resource.init();
			_enemy = new Enemy(220,0);
			add(_enemy);
			//
			_tilemap = new FlxTilemap();
			_tilemap.loadMap(new mapCSV, mapTilesPNG, 16, 16);
            _tilemap.x = 100;
            _tilemap.y = 100;
			add(_tilemap);
            
            _enemy.map = _tilemap;
		}
		

		override public function update():void 
		{
			FlxG.camera.follow(_enemy);
			
            FlxG.collide(_enemy,_tilemap);
			super.update();
		}
	}
}