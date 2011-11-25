package game
{
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	
	import game.actors.BigRock;
	import game.actors.Enemy;
	import game.actors.Player;
	import game.decales.Coin;
	import game.decales.RocketCoin;
	import game.projectiles.Bullet;
	import game.tiles.LevelBase;
	import game.tiles.TileManager;
	
	import org.flixel.FlxBasic;
	import org.flixel.FlxButton;
	import org.flixel.FlxCamera;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	import org.flixel.system.debug.Log;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class PlayState extends FlxState 
	{
		[Embed(source='../assets/audio/effects/heart_bit.mp3')]
		protected var heartBitSnd:Class;
		
		[Embed(source='../assets/textures/ui/btn_pause.png')]
		private var pauseBtnPNG:Class;
        
        [Embed(source='../assets/audio/bg.mp3')]
        protected var bgMusic:Class;
        
		private var _pauseBtn:FlxButton;
		private var _player:Player;
		private var _bigRock:BigRock;
		private var _scoreText:FlxText;
		
		//bullet times stuff
		private var _bulletTimeStart:Boolean;
		private var _bulletTimeDurating:Number;
		private var _pauseLayer:PauseState;
        
        private var _tileMgr:TileManager;
        private var _curTile:FlxTilemap;
		
        private var _preTile:FlxTilemap;
        private var _tiles:FlxGroup = new FlxGroup();
        private var _coins:FlxGroup = new FlxGroup();
        private var _eminies:FlxGroup = new FlxGroup();
		private var _wind:FlxEmitter;
        
		/**
		 * 
		 */
		public function PlayState() 
		{
			super();
			Resource.init();
			FlxG.score = 0;
			
			_player =  new Player(60, 60);
			_bigRock = new BigRock(0,10);

			createHub();
            _tileMgr = new TileManager();
            _curTile = _tileMgr.getTile().map;
            _tiles.add(_curTile);
            
			_wind = initWindEmitter();
			_wind.y = 50
			
			add(_tileMgr.sky);
            add(_tileMgr.tree);
            add(_tiles);
            add(_coins);
            add(_eminies);
			add(_player);
			add(_wind);
			
			_pauseLayer = new PauseState();
			_pauseLayer.resumeCallback = resumeHandler;
			_pauseLayer.enabled = false;
			add(_pauseLayer);
            
            FlxG.playMusic(bgMusic);
            
            //var en:Enemy = new Enemy(120,300);
            //_eminies.add(en);
		}
		
		private function createHub():void 
		{
			_scoreText = new FlxText(0,0,80,null,true);
			_scoreText.setFormat(null,8,0xffffff,"left");
			_scoreText.scrollFactor = new FlxPoint(0,0);
			_scoreText.text = "Score:0";
			_scoreText.x = FlxG.width-_scoreText.width;
			
			_pauseBtn = new FlxButton(2, 2, "", pauseHandler);
			_pauseBtn.loadGraphic(pauseBtnPNG,false,false,16,16)
			_pauseBtn.scrollFactor = new FlxPoint(0, 0);
			
			add(_scoreText);
			add(_pauseBtn);
		}
		
		/**
		 * start bullet time 
		 * @param	time
		 */
		public function startBulletTime(time:Number = .5):void
		{
			FlxG.timeScale = .2;
			_bulletTimeStart = true;
			_bulletTimeDurating = time;
			FlxG.play(heartBitSnd);
		}
		
		/**
		 * pause game handler
         * 
		 */
		private function pauseHandler():void 
		{
			Registry.paused = true;
			
			FlxG.timeScale = 0;
			_pauseLayer.enabled = true;
            FlxG.music.pause();
		}
		
        /**
         * resume 
         * 
         */        
		private function resumeHandler():void
		{
			Registry.paused = false;
            
			FlxG.timeScale = 1
			_pauseLayer.enabled = false;
            FlxG.music.resume();
		}
		
		/**
		 * update
		 */
		override public function update():void 
		{
			_wind.x = _player.x + FlxG.width - 50;;
			FlxG.worldBounds = new FlxRect((FlxG.camera.scroll.x), (FlxG.camera.scroll.y), FlxG.camera.width*2, FlxG.camera.height);
			FlxG.camera.follow(_player);
			FlxG.camera.deadzone = new FlxRect(20,50,30,60);
			
			//update score
			_scoreText.text = "Score:"+String(FlxG.score);
			_scoreText.x = FlxG.width-_scoreText.width;
            
            //draw tile maps
            if (_curTile.x + _curTile.width - _player.x<FlxG.width) 
            {
                _preTile = _curTile;
                var lb:LevelBase = _tileMgr.getTile();
				_curTile = lb.map;
				_curTile.x = _preTile.x + _preTile.width;
				_curTile.y = _preTile.y;
				
				lb.init();
				_coins.add(lb.stars);
				_eminies.add(lb.enemies);
				_tiles.add(_curTile);
            }
            
            if (_preTile)
            {
                //trace("play and tile:"+(_player.x - _preTile.x)+" pre width:"+_preTile.width);
                if ((_player.x - _preTile.x) > (_preTile.width+180))
                {
                    //_tiles.remove(_preTile);
                    //_preTile = null;
                }
                
            }
			
			//collide
            FlxG.collide(_tiles, _eminies);
			FlxG.collide(_tiles, _player);
            FlxG.collide(_eminies, _player);
			FlxG.collide(_tiles, _bigRock);
			
			FlxG.overlap(_player, _coins, getCoin);
			
			//player dead
			if(_player.y > 420 && _player.health>0)
			{
				_player.hurt(1);
			}
			
			//test bullet time
			if(FlxG.keys.T && false == _bulletTimeStart)
			{
				startBulletTime();
			}
			
			if (FlxG.keys.S)
			{
				_player.speedUp();
			}
			
			//bullet time
			if(_bulletTimeStart)
			{
				if(_bulletTimeDurating>0)
				{
					_bulletTimeDurating -= FlxG.elapsed;
				}
				else
				{
					_bulletTimeStart = false;
					FlxG.timeScale = 1;
				}
			}
			super.update();
		}
		
		/**
		 * player collide with enemies
		 * 
		 * @param	obj
		 * @param	obj2
		 */
		private function playerEnemiesCollide(obj:FlxObject,obj2:FlxObject):void
		{
			trace(obj,obj2);
		}
		
		/**
		 * 
		 * @param	ob1
		 * @param	ob2
		 */
		private function getCoin(ob1:FlxSprite,ob2:FlxSprite):void 
		{
			if ((ob2 is Coin) && !(ob2 as Coin).hasGotten) 
			{
				(ob2 as Coin).getCoin();
			}
			if ((ob2 is RocketCoin) && !(ob2 as RocketCoin).hasGotten) 
			{
				(ob2 as RocketCoin).getCoin();
				(ob1 as Player).speedUp();
			}
		}
		
		/**
		 * destroy
		 */
		override public function destroy():void
		{
            FlxG.music.stop();
			FlxG.timeScale = 1;
			FlxG.mouse.show();
            
			_player.destroy();
			_bigRock.destroy();
			super.destroy();
		}
		
		/**
		 * 
		 */
		private function initWindEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter(160, 30, 100);
			emitter.setXSpeed(-100, -50);
			emitter.setYSpeed(0, 100);
			emitter.bounce = .8;
			
			emitter.gravity = 20;
			var whitePixel:FlxParticle;
			for (var i:int = 0; i < emitter.maxSize; i++) 
			{
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(2, 2, 0xFFFFFFFF);
				whitePixel.visible = false; //Make sure the particle doesn't show up at (0, 0)
				emitter.add(whitePixel);
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(1, 1, 0xFFFFFFFF);
				whitePixel.visible = false;
				emitter.add(whitePixel);
			}
			emitter.start(false, 1.6, 0.2);
			return emitter;
		}
	}
}