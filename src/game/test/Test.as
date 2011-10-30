package game.test
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import game.PauseState;
	import game.Registry;
	import game.Resource;
	import game.decales.Coin;
	import game.tiles.LevelBase;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class Test extends FlxState 
	{
		private var _stars:FlxGroup;
		protected var _bg:FlxSprite;
		protected var _bgFlx:FlxSprite;
		
		protected var _titleField:FlxText;
		protected var _introField:FlxText;
		protected var _backBtn:FlxButton;
		
		public function Test() 
		{
			super();
			FlxG.mouse.show();
			_bg = new FlxSprite();
			_bg.makeGraphic(100, 100, 0x66554400);
			add(_bg);
            
            Resource.init();
			
			_stars = new FlxGroup();
            var coin:Coin;
            for (var i:int = 0; i < 50; i++)
            {
                coin = new Coin();
                _stars.add(coin);
            }
            Registry.stars = _stars;
			
			var t:LevelBase = new LevelBase();
            t.x = 100;
            t.y = 80;
            t.init()
           
            this.add(t.map);
            this.add(t.stars);
            this.add(t.enemies);
		}
		
		override public function update():void 
		{
			if (FlxG.mouse.justPressed() && hover(0,20,FlxG.width,FlxG.height-20))
			{
				trace("press area");
			}
			super.update();
		}
		
		public function hover(x:Number, y:Number, width:int, height:int):Boolean 
		{
			var mx:int = FlxG.mouse.screenX;
			var my:int = FlxG.mouse.screenY;
			return ( (mx > x) && (mx < x + width) ) && ( (my > y) && (my < y + height) );
		}
	}

}