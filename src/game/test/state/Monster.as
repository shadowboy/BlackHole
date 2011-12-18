package game.test.state
{
	import flash.media.Video;
	
	import game.OverState;
	import game.Registry;
	import game.Resource;
	import game.actors.PlayerDownEffect;
	import game.actors.PlayerJumpEffect;
	import game.actors.PlayerJumpEffectSecond;
	import game.projectiles.Bullet;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	
	/**
	 * Game player controll and move and other functions
	 * 
	 * @author Andy
	 */
	public class Monster extends FlxSprite
	{
		[Embed(source='../../../assets/textures/actors/duck.png')]
		protected var DuckImg:Class;
		[Embed(source='../../../assets/audio/land.mp3')]
		protected var landSnd:Class;
		[Embed(source='../../../assets/audio/jump.mp3')]
		protected var jumpSnd:Class;
		
		protected static const RUN_SPEED:int = 30;
		protected static const GRAVITY_ACCELERATION:Number = 500;
		protected static const JUMP_MAX:Number = 160;
			
		private var _jumpEffect:PlayerJumpEffect;
		private var _jumpEffect2:PlayerJumpEffectSecond;
		private var _downEffect:PlayerDownEffect;
		private var _jumpStatus:int;
		private var _jumpInSkyTime:int;
		private var _superState:Boolean;
		private var _superStateCount:int;
		private var _superStateMaxTime:int = 120;
		
		/**
		 * Constraction
		 * 
		 * @param startX
		 * @param startY
		 */
		public function Monster()
		{
			super(0, 0);
			loadGraphic(DuckImg, true, true, 16, 18);
			drag.x = RUN_SPEED;
			acceleration.y = GRAVITY_ACCELERATION;
			maxVelocity.x = RUN_SPEED * 5;
			maxVelocity.y = JUMP_MAX;
			
			this.health = 1;
			//add animations
			addAnimation("idle", [0]);
			addAnimation("run", [0, 1, 0, 2], 12);
			addAnimation("jump", [3]);
			addAnimation("jump2", [4, 5, 6, 7, 8], 12, true);
			addAnimation("idle_up", [0]);
			addAnimation("dead", [0, 1, 2, 3], 12, true);
			
			_jumpEffect = new PlayerJumpEffect();
			_jumpEffect2 = new PlayerJumpEffectSecond();
			_downEffect = new PlayerDownEffect();
			
			Registry.paused = false;
		}
		
		/**
		 * Update
		 */
		public override function update():void
		{
			//facing = RIGHT;
            //acceleration.x = 0;
            if(FlxG.keys.justPressed("LEFT"))
            {
                facing = LEFT;
                velocity.x = -RUN_SPEED;
            }
            else if(FlxG.keys.justPressed("RIGHT"))
            {
                facing = RIGHT;
                velocity.x = RUN_SPEED
            }
			//子弹发射设置
			if (FlxG.keys.justPressed('C'))
			{
				var bul:Bullet = Resource.getBullet();
				bul.shoot(x + 4, y, 250, 0);
				FlxG.state.add(bul);
			}
			
			//以下是判断人物的一些速度状态来进行各种动画播放
			if (health <= 0)
			{
				play("dead");
			}
			else if (velocity.y != 0)
			{
				play("jump");
			}
			else if (velocity.x != 0)
			{
				play("run");
			}
			else
			{
				play("idle");
			}
            
			if (health <= 0 && finished)
			{
				kill();
				FlxG.switchState(new OverState());
			}
			super.update();
		}
		
		/**
		 * Be hurt
		 * @param Damage
		 *
		 */
		override public function hurt(Damage:Number):void
		{
			health = health - Damage;
		}
	}
}