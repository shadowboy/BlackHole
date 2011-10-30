package game.actors
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class Enemy extends FlxSprite 
	{
		//人物移动的速度得值
		protected static const PLAYER_RUN_SPEED:int = 80;
		//人物收到的重力加速度的值
		protected static const GRAVITY_ACCELERATION:Number = 400;
		//人物跳跃时的加速度
		protected static const JUMP_ACCELERATION:Number = 200;
		
		[Embed(source = '../../assets/textures/actors/enemy.png')]
		protected var playerImg:Class;
		
		private var _bullets:FlxGroup;
		private var _curBullet:uint = 0;
		
		private var _jump:Boolean;
		private var _isJump:Boolean;
		private var isDying:Boolean;
		public var map:FlxTilemap;
		
		/**
		 *  
		 * @param startX
		 * @param startY
		 * 
		 */		
		public function Enemy(startX:Number,startY:Number) 
		{
			super(startX, startY);
			loadGraphic(playerImg, true, true, 12, 20);
			
			//drag.x = PLAYER_RUN_SPEED * 8;
			acceleration.y = GRAVITY_ACCELERATION;
			
			maxVelocity.x = PLAYER_RUN_SPEED;
			maxVelocity.y = JUMP_ACCELERATION;
			
			addAnimation("idle", [2]);
			addAnimation("run", [0, 1, 2, 3], 12,true);
			addAnimation("jump", [2]);
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
            super.update();
            var tx:int = int(x / 16);
            var ty:int = int(y / 16);
            
            if (facing == FlxObject.LEFT)
            {
                
                //	31 is the Collide Index of our Tilemap (which sadly isn't exposed in Flixel 2.5, so is hard-coded here. Not ideal I appreciate)
                if (map && map.getTile(tx - 2, ty) == 0)
                {
                    turnAround();
                    return;
                }
            }
            else
            {
                //	31 is the Collide Index of our Tilemap (which sadly isn't exposed in Flixel 2.5, so is hard-coded here. Not ideal I appreciate)
                if (map && map.getTile(tx + 2, ty) ==0)
                {
                    turnAround();
                    return;
                }
            }
            
            //	Check the tiles below it
            
            if (isTouching(FlxObject.FLOOR) == false && isDying == false)
            {
                turnAround();
            }
            
            if(this.velocity.x>0)
            {
                play("run");
            }
			
		}
		
        private function turnAround():void
        {
            if (facing == FlxObject.RIGHT)
            {
                facing = FlxObject.LEFT;
                
                velocity.x = -30;
            }
            else
            {
                facing = FlxObject.RIGHT;
                
                velocity.x = 30;
            }
        }
        
	}
}