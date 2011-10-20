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
		[Embed(source="../assets/textures/ui/4345441923_305fbde3a7.jpg")]
		private var bgImg:Class;
		
		[Embed(source="../assets/textures/ui/andy.jpg")]
		private var andyImg:Class;
		
		private var andy:FlxSprite;
		
		public function AboutState() 
		{
			super("I'm about~", bgImg);
			
			andy = new FlxSprite();
			andy.loadGraphic(andyImg, false, false);
			andy.width = 50;
			andy.height = 30;
			andy.x = 20;
			andy.y = 30;
			add(andy);
			
			var str:String = "I'm about~I'm about~I'm about~I'm about~I'm about~I'm about~I'm about~";
			var padding:int = 10;
			var info:FlxText = new FlxText(padding, 4, FlxG.width - 2 * padding, str);
			info.setFormat(null, 8, 0x0, "left");
			add(info);
			
		}
	}
}