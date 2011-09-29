package com.eingzone.lbb.tiles 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTileblock;
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class FrontView extends FlxTileblock
	{
		[Embed(source = '../../../../../src/assets/textures/tiles/front_view.png')]
		protected var bgImg:Class;
		
		public function FrontView() 
		{
			super(0, 0, 1500, 500);
			loadTiles(bgImg);
			this.scrollFactor = new FlxPoint(0.2, 0.2);
		}
		
	}

}