package com.eingzone.lbb.tiles 
{
	import flash.display.Sprite;
	
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;

	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class GroundView extends FlxTilemap
	{
		[Embed(source='../../../../../src/assets/textures/tiles.png')]
		protected var tileImg:Class;
		
		// XML
		[Embed(source = "../../../../../src/assets/levels/mapCSV_Group1_Map1.csv", mimeType = "application/octet-stream")] 
		private var tileData:Class;
		
		public function GroundView() 
		{
			super();

			this.loadMap(new tileData(), tileImg, 16, 16);
			this.setTileProperties(13,FlxObject.NONE);
			this.setTileProperties(14,FlxObject.NONE);
			this.setTileProperties(16,FlxObject.NONE);
			this.setTileProperties(17,FlxObject.NONE);
		}
		
	}

}