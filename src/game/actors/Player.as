package game.actors
{
	import flash.media.Video;
	import game.Registry;
	import org.flixel.FlxParticle;
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Andy
	 */
	public class Player extends FlxSprite 
	{
		//人物移动的速度得值
		protected static const PLAYER_RUN_SPEED:int = 70;
		//人物收到的重力加速度的值
		protected static const GRAVITY_ACCELERATION:Number = 400;
		//人物跳跃时的加速度
		protected static const JUMP_MAX:Number = 120;
		protected static const JUMP_MIN:Number = 60;
		
		protected static const FIRST_JUMP:int = 1;
		protected static const SECOND_JUMP:int = 2;
		
		[Embed(source = '../../assets/textures/actors/spaceman.png')]
		protected var playerImg:Class;
		
		[Embed(source = '../../assets/textures/actors/duck.png')]
		protected var DuckImg:Class;
		
		//飞行背包的 喷气素材
		[Embed(source='../../assets/textures/effects/jet.png')]
		protected var jetImg:Class;
		
		[Embed(source='../../assets/audio/land.mp3')]
		protected var landSnd:Class;
		
		[Embed(source='../../assets/audio/jump.mp3')]
		protected var jumpSnd:Class;
		
		private var _bullets:FlxGroup;
		private var _bulletIndex:uint = 0;
		
		private var _jumpEffect:PlayerJumpEffect
		private var _downEffect:PlayerDownEffect;
		
		private var _jumpStatus:int;
		private var _jumpInSkyTime:int;
		
		private var _superState:Boolean;
		private var _superStateCount:int;
		private var _superStateMaxTime:int = 120;
		
		/**
		 *  
		 * @param startX
		 * @param startY
		 * 
		 */		
		public function Player(startX:Number,startY:Number) 
		{
			super(startX, startY);
			loadGraphic(DuckImg, true, true, 16, 18);
			
			drag.x = PLAYER_RUN_SPEED * 8;
			acceleration.y = GRAVITY_ACCELERATION;
			
			maxVelocity.x = PLAYER_RUN_SPEED;
			maxVelocity.y = JUMP_MAX;
			
			addAnimation("idle", [0]);
			addAnimation("run", [0, 1, 0,2], 12);
			addAnimation("jump", [3]);
			addAnimation("idle_up", [0]);
			
			
			_jumpEffect = new PlayerJumpEffect();
			_downEffect = new PlayerDownEffect();
		}
		
		/**
		 * 
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
		 * 重写update 方法，用于控制 
		 */		
		public override function update():void
		{
			facing = RIGHT;
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
					//add firworks
					FlxG.state.add(Registry.emitters);
					Registry.emitters.start(false, 3, .01);
					Registry.emitters.x = x+8;
					Registry.emitters.y = y+18;
				}
			}
			else
			{
				acceleration.x = drag.x;
			}
			
			if (FlxG.mouse.justPressed())
			{
				trace("justPressed");
				if(velocity.y == 0 && _jumpStatus==0)
				{
					_jumpInSkyTime = 0;
					_jumpStatus = FIRST_JUMP;
					
					_jumpEffect.playAt(this.x-8,this.y+8);
					FlxG.state.add(_jumpEffect);
					velocity.y = -JUMP_MIN;
					
					FlxG.play(jumpSnd);
				}
				else if (velocity.y>0 && _jumpStatus == FIRST_JUMP)
				{
					_jumpInSkyTime = 0;
					_jumpStatus = SECOND_JUMP;
					
					_jumpEffect.playAt(this.x-8,this.y+8);
					FlxG.state.add(_jumpEffect);
					velocity.y = -JUMP_MIN;
					
					FlxG.play(jumpSnd);
				}
			}
			
			if (FlxG.mouse.pressed())
			{
				if(_jumpStatus>0)
				{
					_jumpInSkyTime++;
					if(_jumpInSkyTime<20)
					{
						velocity.y -=10;
					}
				}
			}
			
			//子弹发射设置
			if (FlxG.keys.justPressed('C')) 
			{
				if (Registry.bullets!=null) 
				{
					Registry.bullets.members[_bulletIndex].shoot(x + 4, y, 250, 0);
					
					//子弹已经发射，索引变成下一个的
					_bulletIndex++;
					//求余数的运算，这样 索引就会 循环了
					if (_bulletIndex >= 10)
					{
						_bulletIndex = 0;
					}
					
				}
			}
			
			//以下是判断人物的一些速度状态来进行各种动画播放
			if(velocity.y != 0)
			{
				//y轴速度不为0 的时候，播放跳跃的动画
				play("jump");
			}
			else if(velocity.y == 0 && _jumpStatus!=0)
			{
				_downEffect.playAt(this.x,this.y+8);
				FlxG.state.add(_downEffect);
				
				_jumpStatus = 0;
				_jumpInSkyTime = 0;
				FlxG.play(landSnd);
			}
			else if(velocity.x == 0)
			{
				//y轴速度为 0 了，就判断这里
				//x轴速度为0 的时候，播放闲暇的动画
				play("idle");
			}
			else
			{
				//y轴速度为 0 且 x轴速度不为 0，就播放跑步动画
				play("run");
			}
			
			
			super.update();
		}
		
		/**
		 * 判断鼠标所在位置 
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
			return ( (mx > x) && (mx < x + width) ) && ( (my > y) && (my < y + height) );
		}
		
		/**
		 * destroy
		 * 
		 */		
		override public function destroy():void
		{
			_jumpEffect.destroy();
			_downEffect.destroy();
			super.destroy();
		}
	}
}