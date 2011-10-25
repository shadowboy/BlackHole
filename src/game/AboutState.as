package game 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class AboutState extends BaseOtherState
	{
		[Embed(source="../assets/textures/ui/bg_about.png")]
		private var bgImg:Class;
		
		[Embed(source="../assets/textures/ui/self.png")]
		private var andyImg:Class;
		
		private var andy:FlxSprite;
		
		public function AboutState() 
		{
			super("I'm about~", bgImg);
            var padding:int = 10;
            
			andy = new FlxSprite();
			andy.loadGraphic(andyImg, false, false);
			andy.x = 10;
			andy.y = 30;
			add(andy);
			
			var infoText:String = "When do fresh strawberries come in? When do fresh strawberries come in?";
			var info:FlxText = new FlxText(0,0,FlxG.width - andy.width - 20);
            info.x = andy.x+andy.width+4;
            info.y = andy.y;
            info.text = infoText;
			info.setFormat(null, 8, 0x0, "left");
			add(info);
            
            var thxText:String = "When do fresh strawberries come in?When do fresh strawberries come in?When do fresh strawberries come in?";
            var thx:FlxText = new FlxText(0,0,info.width);
            thx.x = info.x;
            thx.y = info.y+info.height+6;
            thx.text = thxText;
            thx.setFormat(null, 8, 0x0, "left");
            add(thx);
			
		}
	}
}