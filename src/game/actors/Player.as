package game.actors
{
	import flash.media.Video;
	import game.Registry;
	
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
		protected static const PLAYER_RUN_SPEED:int = 130;
		//人物收到的重力加速度的值
		protected static const GRAVITY_ACCELERATION:Number = 420;
		//人物跳跃时的加速度
		protected static const JUMP_ACCELERATION:Number = 260;
		
		protected static const FIRST_JUMP:int = 1;
		protected static const SECOND_JUMP:int = 2;
		
		[Embed(source = '../../assets/textures/actors/spaceman.png')]
		protected var playerImg:Class;
		
		[Embed(source = '../../assets/textures/actors/duck.png')]
		protected var DuckImg:Class;
		
		//飞行背包的 喷气素材
		[Embed(source='../../assets/textures/effects/jet.png')]
		protected var jetImg:Class;
		
		private var _bullets:FlxGroup;
		private var _bulletIndex:uint = 0;
		
		private var _jumpEffect:PlayerJumpEffect
		private var _downEffect:PlayerDownEffect;
		
		private var _jumpStatus:int;
		private var _pressTime:int;
		
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
			maxVelocity.y = JUMP_ACCELERATION;
			
			addAnimation("idle", [0]);
			addAnimation("run", [0, 1, 2], 12);
			addAnimation("jump", [1]);
			addAnimation("idle_up", [0]);

			
			_jumpEffect = new PlayerJumpEffect();
			_downEffect = new PlayerDownEffect();
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
			
			if (FlxG.mouse.justPressed())
			{
				trace("justPressed");
				_pressTime = 0;
			}
			
			if (FlxG.mouse.pressed())
			{
				trace("pressed");
				_pressTime ++;
			}
			
			if (FlxG.mouse.justReleased())
			{
				trace("justReleased:" + _pressTime);
				if (_pressTime > 15)_pressTime = 15;
				var jumpSpeed:Number = (_pressTime / 15) * JUMP_ACCELERATION;
				if(velocity.y == 0)
				{
					_jumpStatus = FIRST_JUMP;
					
					_jumpEffect.playAt(this.x-8,this.y+8);
					FlxG.state.add(_jumpEffect);
					velocity.y = -jumpSpeed;
				}
				else if (_jumpStatus == FIRST_JUMP)
				{
					_jumpStatus = SECOND_JUMP;
					
					_jumpEffect.playAt(this.x-8,this.y+8);
					FlxG.state.add(_jumpEffect);
					velocity.y = -jumpSpeed;
				}
			}
			
			if (FlxG.mouse.justPressed() && hover(50,10,600,400))
			{
				
				
			}
			
			//子弹发射设置
			if (FlxG.keys.justPressed('C')) 
			{
				if (Registry.bullets!=null) 
				{
					trace(_bulletIndex);

					trace(Registry.bullets.members[_bulletIndex]);
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