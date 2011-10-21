package game.test
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import game.PauseState;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
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
		
		[Embed(source = "auto_build_map.txt", mimeType = "application/octet-stream")] 
		public var mapCSV:Class;
		
		protected var _tilemap:FlxTilemap;
		protected var _bgFlx:FlxSprite;
		
		protected var _titleField:FlxText;
		protected var _introField:FlxText;
		protected var _backBtn:FlxButton;
		
		public function TestAutoBuildMap() 
		{
			super();
			_tilemap = new FlxTilemap();
			_tilemap.loadMap(new mapCSV, mapTilesPNG, 16, 16);
			_tilemap.setTile(2, 2, 4);
			add(_tilemap);
		}
		
		override public function update():void 
		{
			if (FlxG.mouse.justPressed())
			{
				trace("press area");
			}
			super.update();
		}
	}
}