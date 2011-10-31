package game 
{
	import game.actors.Enemy;
	import game.decales.Coin;
	import game.projectiles.Bullet;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxGroup;
	import org.flixel.FlxParticle;
	
	/**
	 * Resources init place
	 * @author Andy Cao
	 */
	public class Resource 
	{
		static private var _bullets:FlxGroup;
		static private var _emitters:FlxGroup;
		static private var _coins:FlxGroup;
        static private var _coinEmitters:FlxGroup;
        static private var _enimies:FlxGroup;
		
		static private var _curBulletIdx:int;
		static private var _curCoinIdx:int;
		static private var _curEmitterIdx:int;
		static private var _curCoinEmitterIdx:int;
		static private var _curEnimyIdx:int;
		
		/**
		 * 
		 */
		public function Resource() 
		{
			
		}
		
		/**
		 * get coins
		 * @return
		 */
		public static function getCoin():Coin
		{
			if (_curCoinIdx >= _coins.length-1)
            {
                _curCoinIdx = 0;
            }
            else
            {
                _curCoinIdx++;
            }
            return _coins.members[_curCoinIdx] as Coin;
		}
		
		/**
		 * get bullets
		 * @return
		 */
		public static function getBullet():Bullet
		{
			if (_curBulletIdx >= _bullets.length-1)
            {
                _curBulletIdx = 0;
            }
            else
            {
                _curBulletIdx++;
            }
            return _bullets.members[_curBulletIdx] as Bullet;
		}
		
		/**
		 * get emitter
		 * @return
		 */
		public static function getEmitter():FlxEmitter
		{
			if (_curEmitterIdx >= _emitters.length-1)
            {
                _curEmitterIdx = 0;
            }
            else
            {
                _curEmitterIdx++;
            }
            return _emitters.members[_curEmitterIdx] as FlxEmitter;
		}
        
        /**
         * get emitter
         * @return
         */
        public static function getEnemy():Enemy
        {
            if (_curEnimyIdx >= _enimies.length-1)
            {
                _curEnimyIdx = 0;
            }
            else
            {
                _curEnimyIdx++;
            }
            return _enimies.members[_curEnimyIdx] as Enemy;
        }
		
		/**
		 * init resources
		 */
		public static function init():void
		{
			initBullets();
			initCoins();
			initEmitters();
            initEnemies();
		}
        
		/**
		 * 
		 */
		private static function initBullets():void
		{
			_bullets = new FlxGroup();
			var bul:Bullet;
			for (var i:int = 0; i < 5; i++)
			{
				bul = new Bullet();
				_bullets.add(bul);
			}
			Registry.bullets = _bullets;
		}
		
		/**
		 * 
		 */
		private static function initCoins():void
		{
            _coins = new FlxGroup();
            var coin:Coin;
            for (var i:int = 0; i < 30; i++)
            {
                coin = new Coin();
                _coins.add(coin);
            }
            Registry.stars = _coins;
		}
		
		/**
		 * 
		 */
		private static function initEmitters():void
		{
			_emitters = new FlxGroup();
            var emitter:FlxEmitter;
            for (var i:int = 0; i < 3; i++)
            {
                emitter = initEmitter();
                _emitters.add(emitter);
            }
            Registry.emitters = _emitters;
		}
		
		/**
		 * 
		 */
		private static function initEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter(0, 0, 6);
			emitter.setXSpeed(-100, 0);
			emitter.setYSpeed(0, 100);
			//emitter.bounce = .8;
			
			emitter.gravity = 100;
			var whitePixel:FlxParticle;
			for (var i:int = 0; i < emitter.maxSize; i++) 
			{
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(4, 4, 0xFFFFFFFF);
				whitePixel.visible = false; //Make sure the particle doesn't show up at (0, 0)
				emitter.add(whitePixel);
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(2, 2, 0xFFFFFFFF);
				whitePixel.visible = false;
				emitter.add(whitePixel);
			}
			return emitter;
		}
        
        private static function initCoinEmitter():FlxEmitter
        {
            var emitter:FlxEmitter = new FlxEmitter(0, 0, 6);
            emitter.setXSpeed(-50, 50);
            emitter.setYSpeed(-50, 50);
            emitter.bounce = .8;
            emitter.gravity = 100;
            var whitePixel:FlxParticle;
            for (var i:int = 0; i < emitter.maxSize; i++) {
                whitePixel = new FlxParticle();
                whitePixel.makeGraphic(4, 4, 0xFFFFFFFF);
                whitePixel.visible = false; //Make sure the particle doesn't show up at (0, 0)
                emitter.add(whitePixel);
                whitePixel = new FlxParticle();
                whitePixel.makeGraphic(2, 2, 0xFFFFFFFF);
                whitePixel.visible = false;
                emitter.add(whitePixel);
            }
            return emitter;
        }
        
        
        private static function initEnemies():void
        {
            _enimies = new FlxGroup();
            var eni:Enemy;
            for (var i:int = 0; i < 2; i++)
            {
                eni = new Enemy(0,0);
                _enimies.add(eni);
            }
        }
        
	}
}