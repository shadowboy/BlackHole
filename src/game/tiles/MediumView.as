package game.tiles 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTileblock;
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class MediumView extends FlxTileblock
	{
		[Embed(source = '../../assets/textures/tiles/medium_view.png')]
		protected var bgImg:Class;
		
		public function MediumView() 
		{
			super(0, 0, 1500, 500);
			loadTiles(bgImg);
			this.scrollFactor = new FlxPoint(0.2, 0.2);
		}
		
	}

}