package com.eingzone.lbb.tiles 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxTileblock;
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class DistantView extends FlxTileblock
	{
		[Embed(source = '../../../../../src/assets/textures/tiles/sky_clouds.png')]
		protected var bgImg:Class;
		
		public function DistantView() 
		{
			super(0,0,1500,1500)
			loadGraphic(bgImg);
			this.scrollFactor = new FlxPoint(0.01, 0.01);
		}
		
	}

}