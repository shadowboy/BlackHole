package game.actors
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class Enemy extends FlxSprite 
	{
		//人物移动的速度得值
		protected static const PLAYER_RUN_SPEED:int = 80;
		//人物收到的重力加速度的值
		protected static const GRAVITY_ACCELERATION:Number = 420;
		//人物跳跃时的加速度
		protected static const JUMP_ACCELERATION:Number = 200;
		
		[Embed(source = '../../assets/textures/actors/spaceman.png')]
		protected var playerImg:Class;
		
		private var _bullets:FlxGroup;
		private var _curBullet:uint = 0;
		
		private var _jump:Boolean;
		private var _isJump:Boolean;
		
		/**
		 *  
		 * @param startX
		 * @param startY
		 * 
		 */		
		public function Enemy(startX:Number,startY:Number) 
		{
			super(startX, startY);
			loadGraphic(playerImg, true, true, 8, 8);
			
			//drag.x = PLAYER_RUN_SPEED * 8;
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
		
		public function set jump(value:Boolean):void
		{
			_jump = value;
		}
		
		/**
		 * 重写update 方法，用于控制 
		 */		
		public override function update():void
		{
			//当不按按钮的时候，人物加速度为0，就那么人物会收到drag影响而停下来
			acceleration.x = 0;
			
			facing = LEFT;
			acceleration.x = drag.x;
			
			if (int(FlxG.random()*10)==1 && velocity.y == 0)
			{
				_isJump = true;
				velocity.y = -JUMP_ACCELERATION;
			}
			
			//以下是判断人物的一些速度状态来进行各种动画播放
			if(velocity.y != 0)
			{
				//y轴速度不为0 的时候，播放跳跃的动画
				play("jump");
			}
			else if(velocity.x == 0)
			{
				play("idle");
			}
			else
			{
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
			super.destroy();
		}
	}
}