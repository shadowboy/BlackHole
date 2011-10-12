package game.projectiles
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author zb
	 */
	public class Bullet extends FlxSprite 
	{
		private var dead:Boolean = false;
		[Embed(source = '../../assets/textures/projectiles/bullet.png')]
		protected var bulImg:Class;
		
		private var _walls:FlxGroup;
		
		public function Bullet():void 
		{
			//记得每个FlxSprite的子类构造方法这里 都顺手写一个这个哦
			super(0, 0);
			
			//加载子弹的素材
			loadGraphic(bulImg, true, false, 8, 8);
			
			//设置子弹的动画
			//向上发射
			addAnimation('shootUp', [0]);
			//向下
			addAnimation('shootDown', [1]);
			//向左
			addAnimation('shootLeft', [2]);
			//向右
			addAnimation('shootRight', [3]);
			//爆炸动画，最后一个参数设置false，表示动画播不会循环播放
			addAnimation('BulBoom', [4, 5, 6, 7], 50, false);
			
			//exists,是所有flxObject的一个属性，表示该object是否存在
			//false,说明改物体不存在,flixel不会对他进行任何操作（碰撞检测等）
			//true，则说明改物体存在
			//当子弹没有发射出去的时候，自然不需要检测碰撞，所以设置 false
			exists = false;
		}
		
		/**
		 * 这个是子弹的发射方法
		 * @param	sPosX 子弹发射时的初始 x 坐标
		 * @param	sPosY 子弹发射时的初始 y 坐标
		 * @param	velX 设置子弹发射的 x轴 速度
		 * @param	velY 设置子弹发射的 y轴 速度
		 */
		public function shoot(sPosX:Number,sPosY:Number,velX:Number,velY:Number):void 
		{
			//reset方法，是将该object的一些属性重置
			//重置 exist 为 true ，dead（是否死亡）为 false
			//参数1：要将该object 重置到的 x坐标
			//参数2：要将该object 重置到的 y坐标
			reset(sPosX, sPosY);
			
			//将参数中的速度赋值给 子弹
			velocity.x = velX;
			velocity.y = velY;
			
			//根据速度判断子弹需要 播放哪个方向的动画
			if (velY < 0) 
			{
				//y速度小于 0，向上发射
				play('shootUp');
			}
			else if (velY > 0) 
			{
				//y速度大于 0，向下发射
				play('shootDown');
			}
			else if (velX < 0) 
			{
				//x速度小于0，向左发射
				play('shootLeft');
			}
			else if (velX > 0) 
			{
				//x速度大于0，向右发射
				play('shootRight');
			}
		}
		
		//重写一下 hurt 方法,因为需要在 碰到障碍物的时候要设置些东东
		//比如 子弹速度 以及 播放爆炸的动画
		//参数：本objcet 所受到的 伤害值
		override public function hurt(Damage:Number):void 
		{
			trace(this, "hurt :" + Damage);
			if (dead) 
			{
				return;
			}
			
			dead = true;
			
			velocity.x = 0;
			velocity.y = 0;
			
			//播放爆炸动画了
			play('BulBoom');
		}
		
		override public function update():void 
		{
			if (dead && finished) 
			{
				exists = false;
			}else 
			{
				super.update();
			}
		}
		
		public function set walls(value:FlxGroup):void 
		{
			_walls = value;
		}
	}
}