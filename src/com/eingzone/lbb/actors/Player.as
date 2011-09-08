package com.eingzone.lbb.actors
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class Player extends FlxSprite 
	{
		//人物移动的速度得值
		protected static const PLAYER_RUN_SPEED:int = 80;
		//人物收到的重力加速度的值
		protected static const GRAVITY_ACCELERATION:Number = 420;
		//人物跳跃时的加速度
		protected static const JUMP_ACCELERATION:Number = 200;
		
		[Embed(source = 'assets/textures/actors/spaceman.png')] protected var playerImg:Class;
		[Embed(source="assets/audio/actors/jump.mp3")] private var JumpSound:Class;
		
		private var _bullets:FlxGroup;
		private var currentBul:uint = 0;
		
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
		}
		
		/**
		 * 
		 */
		public function set bullets(value:FlxGroup):void 
		{
			_bullets = value;
		}
		
		
		//重写update 方法，用于控制
		public override function update():void
		{
			//当不按按钮的时候，人物加速度为0，就那么人物会收到drag影响而停下来
			acceleration.x = 0;
			
			if(FlxG.keys.LEFT)
			{
				facing = LEFT;
				acceleration.x = -drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				acceleration.x = drag.x;
			}
			
			if(FlxG.keys.justPressed('X'))
			{
				velocity.y = -JUMP_ACCELERATION;
				FlxG.play(JumpSound);
			}
			
			//子弹发射设置
			//为了让教程的顺序比较好写，这里加了个判断
			//这样 子弹 就不需要在Player构造的时候必须存在了
			if (_bullets!=null) 
			{
				//按 C 键 发射子弹吧
				if (FlxG.keys.justPressed('C')) 
				{
					trace(currentBul);
					
					//按 上 的时候 向上 发射子弹
					if (facing==LEFT) 
					{
						_bullets.members[currentBul].shoot(x-4, y, -250, 0);
					}
					else if(facing==RIGHT)
					{
						//人物面向右的时候 向右发射子弹
						_bullets.members[currentBul].shoot(x+4, y, 250, 0);
					}
					//子弹已经发射，索引变成下一个的
					currentBul++;
					
					//求余数的运算，这样 索引就会 循环了
					if (currentBul >= 10)
					{
						currentBul = 0;
					}
					
				}
			}
			
			//以下是判断人物的一些速度状态来进行各种动画播放
			//看清楚 if，else if的判断，所以只会做其中一个，按优先级来排列判断内容
			if(velocity.y != 0)
			{
				//y轴速度不为0 的时候，播放跳跃的动画
				play("jump");
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
			
			/*** 切记 ***/
			//这个语句一定要加上去，只要重写了update，就一定要调用 super的update
			//否则不会刷新动画。。也不会相应你在这里所设置的控制
			super.update();
		}
		
	}

}