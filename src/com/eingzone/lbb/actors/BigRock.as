package com.eingzone.lbb.actors
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class BigRock extends FlxSprite 
	{
		//人物移动的速度得值
		protected static const PLAYER_RUN_SPEED:int = 70;
		//人物收到的重力加速度的值
		protected static const GRAVITY_ACCELERATION:Number = 420;
		//人物跳跃时的加速度
		protected static const JUMP_ACCELERATION:Number = 200;
		
		[Embed(source = '../../../../../src/assets/textures/actors/big_rock.png')]
		protected var playerImg:Class;
		
		

		
		public function BigRock(startX:Number,startY:Number) 
		{
			super(startX, startY);
			loadGraphic(playerImg, true, true, 60, 60);
			
			drag.x = PLAYER_RUN_SPEED * 8;
			acceleration.y = GRAVITY_ACCELERATION;
			
			maxVelocity.x = PLAYER_RUN_SPEED;
			maxVelocity.y = JUMP_ACCELERATION;
			

			addAnimation("run", [0], 12);
		}
		
		
		//重写update 方法，用于控制
		public override function update():void
		{

			facing = RIGHT;
			acceleration.x = drag.x;
			
			play("run");
			
			if(this.velocity.y == 0)
			{
				FlxG.shake(0.005);
			}
			super.update();
		}
		
	}

}