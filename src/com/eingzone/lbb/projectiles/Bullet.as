package com.eingzone.lbb.projectiles
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author zb
	 */
	public class Bullet extends FlxSprite 
	{
		
		[Embed(source = 'assets/textures/projectiles/bullet.png')] protected var bulImg:Class;
		[Embed(source="assets/audio/projectiles/shoot.mp3")] private var ShootSound:Class;
		[Embed(source="assets/audio/projectiles/hit.mp3")] private var HitSound:Class;
		
		private var dead:Boolean = false;
		private var _walls:FlxGroup;
		
		public function Bullet():void 
		{
			//记得每个FlxSprite的子类构造方法这里 都顺手写一个这个哦
			super(0, 0);
			
			//加载子弹的素材
			loadGraphic(bulImg, true, false, 8, 8);
			
			addAnimation('shootUp', [0]);
			//向下
			addAnimation('shootDown', [1]);
			//向左
			addAnimation('shootLeft', [2]);
			//向右
			addAnimation('shootRight', [3]);
			//爆炸动画，最后一个参数设置false，表示动画播不会循环播放
			addAnimation('BulBoom', [4, 5, 6, 7], 50, false);
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
			exists = false;
			dead = false;
			
			reset(sPosX, sPosY);
			
			velocity.x = velX;
			velocity.y = velY;
			
			if (velY < 0) 
			{
				play('shootUp');
			}
			else if (velY > 0) 
			{
				play('shootDown');
			}
			else if (velX < 0) 
			{
				play('shootLeft');
			}
			else if (velX > 0) 
			{
				play('shootRight');
			}
			FlxG.play(ShootSound);
		}
		
		override public function hurt(Damage:Number):void 
		{
			if (dead) 
			{
				return;
			}
			
			dead = true;
			FlxG.play(HitSound);
			velocity.x = 0;
			velocity.y = 0;
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