package com.eingzone.lbb.actors
{
	import flash.media.Video;
	
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
		protected static const PLAYER_RUN_SPEED:int = 90;
		//人物收到的重力加速度的值
		protected static const GRAVITY_ACCELERATION:Number = 420;
		//人物跳跃时的加速度
		protected static const JUMP_ACCELERATION:Number = 200;
		
		[Embed(source = '../../../../../src/assets/textures/actors/spaceman.png')]
		protected var playerImg:Class;
		
		//飞行背包的 喷气素材
		[Embed(source='../../../../../src/assets/textures/effects/jet.png')]
		protected var jetImg:Class;
		
		private var _bullets:FlxGroup;
		private var _curBullet:uint = 0;
		
		private var _jumpEffect:PlayerJumpEffect
		private var _downEffect:PlayerDownEffect;
		
		private var _jump:Boolean;
		private var _isJump:Boolean;
		
		/**
		 *  
		 * @param startX
		 * @param startY
		 * 
		 */		
		public function Player(startX:Number,startY:Number) 
		{
			super(startX, startY);
			loadGraphic(playerImg, true, true, 8, 8);
			
			drag.x = PLAYER_RUN_SPEED * 8;
			acceleration.y = GRAVITY_ACCELERATION;
			
			maxVelocity.x = PLAYER_RUN_SPEED;
			maxVelocity.y = JUMP_ACCELERATION;
			
			addAnimation("idle", [0]);
			addAnimation("run", [1, 2, 3, 0], 12);
			addAnimation("jump", [4]);
			addAnimation("idle_up", [5]);
			addAnimation("run_up", [6, 7, 8, 5], 12);
			addAnimation("jump_up", [9]);
			addAnimation("jump_down", [10]);
			
			_jumpEffect = new PlayerJumpEffect();
			_downEffect = new PlayerDownEffect();
		}
		
		/**
		 * 
		 */
		public function set bullets(value:FlxGroup):void 
		{
			_bullets = value;
		}
		
		public function set jump(value:Boolean):void
		{
			_jump = value;
		}
		
		public function reduceSpeed():void
		{
			if(drag.x>100)
			{
				drag.x -=10;
			}
		}
		
		/**
		 * 重写update 方法，用于控制 
		 */		
		public override function update():void
		{
			//当不按按钮的时候，人物加速度为0，就那么人物会收到drag影响而停下来
			acceleration.x = 2;
			
			facing = RIGHT;
			acceleration.x = drag.x;
			
			if (FlxG.mouse.justPressed() && velocity.y == 0)
			{
				_isJump = true;
				if(velocity.y == 0)
				{
					_jumpEffect.playAt(this.x-8,this.y);
					FlxG.state.add(_jumpEffect);
				}
				velocity.y = -JUMP_ACCELERATION;
			}
			
			//子弹发射设置
			if (_bullets!=null) 
			{
				if (FlxG.keys.justPressed('C')) 
				{
					trace(_curBullet);
					
					//按 上 的时候 向上 发射子弹
					if (facing==LEFT) 
					{
						_bullets.members[_curBullet].shoot(x-4, y, -250, 0);
					}
					else if(facing==RIGHT)
					{
						_bullets.members[_curBullet].shoot(x+4, y, 250, 0);
					}
					//子弹已经发射，索引变成下一个的
					_curBullet++;
					
					//求余数的运算，这样 索引就会 循环了
					if (_curBullet >= 10)
					{
						_curBullet = 0;
					}
					
				}
			}
			
			//以下是判断人物的一些速度状态来进行各种动画播放
			if(velocity.y != 0)
			{
				//y轴速度不为0 的时候，播放跳跃的动画
				play("jump");
			}
			else if(velocity.y == 0 && _isJump)
			{
				_isJump = false;
				
				_downEffect.playAt(this.x,this.y);
				FlxG.state.add(_downEffect);
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