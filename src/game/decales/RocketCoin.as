package game.decales
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author zb
	 */
	public class RocketCoin extends FlxSprite 
	{
		
		//金币素材
		[Embed(source = '../../assets/textures/decales/rocket_icon.gif')]
		protected var coinImg:Class;
		
		//拾取金币时的音效
		[Embed(source = '../../assets/audio/decales/pickup.mp3')]
		protected var getSnd:Class;
		
		protected var _score:FlxText;
		//金币是否已经被拾取的 标识
		public var hasGotten:Boolean = false;
		
		/**
		 * 
		 * @param px
		 * @param py
		 * 
		 */		
		public function RocketCoin(x:int=0,y:int=0):void 
		{
			super(x, y);
			
			loadGraphic(coinImg, true, false, 8, 8);
			addAnimation('roll', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 12);
			play('roll');
			
			_score = new FlxText(0, 0, 30, "+50");
		}
		
		/**
		 * 
		 */
		public function getCoin():void 
		{
			//获取金币时 设置为 true
			hasGotten = true;
			
			FlxG.play(getSnd);
			_score.x = x+10;
			_score.y = y
			FlxG.state.add(_score);
			
			
		}
		
		/**
		 * 
		 */
		override public function update():void 
		{
			if (hasGotten) 
			{
				FlxG.score += 50;
				FlxG.state.remove(_score);
				this.kill();
			}
			if (hasGotten)
			{
				_score.y --;
				_score.alpha -=0.1
			}
			
			super.update();
		}
	}
	
}