package game.decales
{
	import game.Resource;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author zb
	 */
	public class Coin extends FlxSprite 
	{
		
		//金币素材
		[Embed(source = '../../assets/textures/decales/star.png')]
		protected var coinImg:Class;
		
		//拾取金币时的音效
		[Embed(source = '../../assets/audio/decales/pickup.mp3')]
		protected var getSnd:Class;
		
		private var _emitter:FlxEmitter;
		protected var _score:FlxText;
		//金币是否已经被拾取的 标识
		public var hasGotten:Boolean = false;
		
		/**
		 * 
		 * @param px
		 * @param py
		 * 
		 */		
		public function Coin(x:int=0,y:int=0):void 
		{
			super(x, y);
			
			loadGraphic(coinImg, false, false, 16, 16);
			addAnimation('roll', [0,1]);
			
			_score = new FlxText(0, 0, 30, "+50");
		}
		
		/**
		 * 重置coin
		 * @param	px
		 * @param	py
		 */
		public function showCoin(px:int,py:int):void
		{
			reset(px,py);
			
			hasGotten = false;
			finished = false;
			play('roll');
		}
		
		/**
		 * 
		 */
		public function getCoin():void 
		{
			//获取金币时 设置为 true
			hasGotten = true;
			
            var emitter:FlxEmitter = Resource.getEmitter();
            emitter.setXSpeed(-50, 50);
            emitter.setYSpeed(-50, 50);
            emitter.bounce = .8;
            emitter.gravity = 100;
			FlxG.state.add(emitter);
            emitter.x = x;
            emitter.y = y;
            emitter.start(true, 1, .01);
			
			this.velocity.y = -100;
			acceleration.y = 300;
			maxVelocity.y = 300;
			
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
			if (this.velocity.y >=50 && hasGotten) 
			{
				FlxG.score += 50;
				FlxG.state.remove(_score);
				FlxG.state.remove(_emitter);
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