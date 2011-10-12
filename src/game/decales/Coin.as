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
	public class Coin extends FlxSprite 
	{
		
		//金币素材
		[Embed(source = '../../assets/textures/decales/coin.png')]
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
			
			loadGraphic(coinImg, true, false, 8, 8);
			addAnimation('roll', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 12);
			
			_score = new FlxText(0,0,30,"+50");
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
			firework();
			
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
				this.kill();
			}
			if (hasGotten)
			{
				_score.y --;
				_score.alpha -=0.1
			}
			
			super.update();
		}
		
		/**
		 * 吃金币的火花
		 */
		private function firework():void
		{
			_emitter = new FlxEmitter(this.x, this.y, 10);
			
			//Now by default the emitter is going to have some properties set on it and can be used immediately
			//but we're going to change a few things.
			
			//First this emitter is on the side of the screen, and we want to show off the movement of the particles
			//so lets make them launch to the right.
			_emitter.setXSpeed(-50, 50);
			
			//and lets funnel it a tad
			_emitter.setYSpeed(-50, 50);
			
			//Let's also make our pixels rebound off surfaces
			_emitter.bounce = .8;
			
			_emitter.gravity = 100;
			//Now let's add the emitter to the state.
			FlxG.state.add(_emitter);
			
			//Now it's almost ready to use, but first we need to give it some pixels to spit out!
			//Lets fill the emitter with some white pixels
			var whitePixel:FlxParticle;
			for (var i:int = 0; i < _emitter.maxSize; i++) {
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(4, 4, 0xFFFFFFFF);
				whitePixel.visible = false; //Make sure the particle doesn't show up at (0, 0)
				_emitter.add(whitePixel);
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(2, 2, 0xFFFFFFFF);
				whitePixel.visible = false;
				_emitter.add(whitePixel);
			}
			
			_emitter.start(true, 1, .01);
		}
	}
	
}