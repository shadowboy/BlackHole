package game.actors
{
	import flash.media.Video;
	import game.projectiles.Bullet;
	import game.Resource;
	
	import game.OverState;
	import game.Registry;
	
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
	public class Player extends FlxSprite
	{
		[Embed(source='../../assets/textures/actors/spaceman.png')]
		protected var playerImg:Class;
		[Embed(source='../../assets/textures/actors/duck.png')]
		protected var DuckImg:Class;
		[Embed(source='../../assets/textures/effects/jet.png')]
		protected var jetImg:Class;
		[Embed(source='../../assets/audio/land.mp3')]
		protected var landSnd:Class;
		[Embed(source='../../assets/audio/jump.mp3')]
		protected var jumpSnd:Class;
		
		protected static const RUN_SPEED:int = 30;
		protected static const GRAVITY_ACCELERATION:Number = 400;
		protected static const JUMP_MAX:Number = 160;
		protected static const JUMP_MIN:Number = 80;
		protected static const FIRST_JUMP:int = 1;
		protected static const SECOND_JUMP:int = 2;
			
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
		public function Player(startX:Number, startY:Number)
		{
			super(startX, startY);
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
		 * Speed up
		 */
		public function speedUp():void
		{
			if (!_superState)
			{
				_superState = true;
				_superStateCount = 0;
			}
		}
		
		/**
		 * Show a tip on player right-top to show text. 
		 */
		public function say():void
		{
		
		}
		
		/**
		 * Update
		 */
		public override function update():void
		{
			facing = RIGHT;
			//Super jump
			if (_superState)
			{
				// super state count time
				_superStateCount++;
				if (_superStateCount > _superStateMaxTime)
				{
					//super state is over
					acceleration.x = drag.x;
					acceleration.y = GRAVITY_ACCELERATION;
					_superState = false;
					//remove firworks
					FlxG.state.remove(Registry.emitters);
				}
				else
				{
					acceleration.x = 600;
					acceleration.y = -650;
				}
			}
			else
			{
				acceleration.x = drag.x;
			}
			
			//控制器
			var justPressed:Boolean = false;
			var pressed:Boolean = false;
			if (false == FlxG.mobile)
			{
				if (FlxG.mouse.justPressed() && hover(0, 20, FlxG.width, FlxG.height - 20) && !Registry.paused)
				{
					justPressed = true;
				}
				if (FlxG.mouse.pressed() && hover(0, 20, FlxG.width, FlxG.height - 20) && !Registry.paused)
				{
					pressed = true;
				}
			}
			else
			{
				if (FlxG.keys.justPressed("SPACE"))
				{
					justPressed = true;
				}
				if (FlxG.keys.pressed("SPACE"))
				{
					pressed = true;
				}
			}
			
			if (justPressed)
			{
				if (velocity.y == 0 && _jumpStatus == 0)
				{
					_jumpInSkyTime = 0;
					_jumpStatus = FIRST_JUMP;
					
					_jumpEffect.playAt(this.x - 12, this.y + 10);
					FlxG.state.add(_jumpEffect);
					velocity.y = -JUMP_MIN;
					
					FlxG.play(jumpSnd);
				}
				else if (velocity.y > 0 && _jumpStatus == FIRST_JUMP)
				{
					_jumpInSkyTime = 0;
					_jumpStatus = SECOND_JUMP;
					
					_downEffect.playAt(this.x - 7, this.y + 14);
					FlxG.state.add(_downEffect);
					velocity.y = -JUMP_MIN / 2;
					
					FlxG.play(jumpSnd);
				}
			}
			
			if (pressed)
			{
				if (_jumpStatus > 0)
				{
					_jumpInSkyTime++;
					if (_jumpInSkyTime < 20)
					{
						velocity.y -= 10;
					}
				}
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
			else if (velocity.y != 0 && _jumpStatus == 1)
			{
				play("jump");
			}
			else if (velocity.y != 0 && _jumpStatus == 2)
			{
				play("jump2");
			}
			else if (velocity.x > 0)
			{
				play("run");
			}
			else
			{
				play("idle");
			}
			
			//Show run dusty effect
			if (this.velocity.x > 120 && this.touching == FlxObject.FLOOR)
			{
				if (_jumpEffect.finished == true)
				{
					_jumpEffect.playAt(this.x - 12, this.y + 10);
					FlxG.state.add(_jumpEffect);
				}
			}
			
			//Show land to ground effect
			if (velocity.y == 0 && _jumpStatus != 0 && touching == FlxObject.FLOOR)
			{
				_downEffect.playAt(this.x - 7, this.y + 14);
				FlxG.state.add(_downEffect);
				
				_jumpStatus = 0;
				_jumpInSkyTime = 0;
				FlxG.play(landSnd);
			}
			
			if (health <= 0 && finished)
			{
				kill();
				FlxG.switchState(new OverState());
			}
			super.update();
		}
		
		/**
		 * Check mouse position
		 * 
		 * @param x
		 * @param y
		 * @param width
		 * @param height
		 * @return
		 *
		 */
		public function hover(x:Number, y:Number, width:int, height:int):Boolean
		{
			var mx:int = FlxG.mouse.screenX;
			var my:int = FlxG.mouse.screenY;
			return ((mx > x) && (mx < x + width)) && ((my > y) && (my < y + height));
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
		
		/**
		 * destroy
		 */
		override public function destroy():void
		{
			_jumpEffect.destroy();
			_downEffect.destroy();
			super.destroy();
		}
	}
}