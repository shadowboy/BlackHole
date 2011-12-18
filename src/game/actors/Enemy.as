package game.actors
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTile;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class Enemy extends FlxSprite 
	{
		//人物移动的速度得值
		protected static const PLAYER_RUN_SPEED:int = 30;
		//人物收到的重力加速度的值
		protected static const GRAVITY_ACCELERATION:Number = 200;
		//人物跳跃时的加速度
		protected static const JUMP_ACCELERATION:Number = -200;
		
		[Embed(source = '../../assets/textures/actors/baddie_cat_1.png')]
		protected var playerImg:Class;
		
		private var _bullets:FlxGroup;
		private var _curBullet:uint = 0;
		
		private var _jump:Boolean;
		private var _isJump:Boolean;
		private var isDying:Boolean;
		private var _emitter:Object;
		private var _map:FlxTilemap;
		
		/**
		 *  
		 * @param startX
		 * @param startY
		 * 
		 */		
		public function Enemy(startX:Number,startY:Number) 
		{
			super(startX, startY);
			loadGraphic(playerImg, true, true, 16, 16);
			
			//drag.x = PLAYER_RUN_SPEED * 8;
			acceleration.y = GRAVITY_ACCELERATION;
			
			maxVelocity.x = PLAYER_RUN_SPEED;
			//maxVelocity.y = JUMP_ACCELERATION;
			
			addAnimation("idle", [2]);
			addAnimation("run", [0,1,2], 12,true);
			addAnimation("jump", [2]);
            
            health =1;
            this.velocity.x = 30;
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
        
        public function set map(value:FlxTilemap):void
        {
            _map = value;
        }
		
		/**
		 * 重写update 方法，用于控制 
		 */		
		public override function update():void
		{
            super.update();
            //acceleration.x = PLAYER_RUN_SPEED;
            
            var tx:int = Math.round((x-_map.x) / 16);
            var ty:int = Math.round((y-_map.y) / 16);
            
//            trace("ty:"+ty);
//            trace("ty-1:",_map.getTile(tx+1,ty-1));
//            trace("ty:",_map.getTile(tx+1,ty));
//            trace("ty+1:",_map.getTile(tx+1,ty+1));
//            
            if (facing == FlxObject.LEFT)
            {
                if (_map.getTile(tx-1,ty)>0)
                {
                    //如果前方有障碍就转头
                    turnAround();
                }
                else if(_map.getTile(tx-1,ty+1)<=0 && isTouching(FlxObject.FLOOR))
                {
                    //如果在地面行走的时候发现前方左下角为空时回头
                    turnAround(); 
                }
                    
            }
            else
            {
                if (_map.getTile(tx+1, ty) >0)
                {
                    turnAround();
                }
                else if(_map.getTile(tx+1,ty+1)<=0 && isTouching(FlxObject.FLOOR))
                {
                    turnAround();
                }
                
                
            }
           
            
            if (int(Math.random() * 30) == 2 && this.velocity.y == 0 )
			{
				//this.velocity.y = JUMP_ACCELERATION;
			}
			
            if (health <= 0)
            {
                
            }
            else if (this.velocity.y > 0)
			{
				play("jump");
			}
			else if(Math.abs(this.velocity.x)>0)
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
        
        /**
         * Be hurt
         * @param Damage
         *
         */
        override public function hurt(Damage:Number):void
        {
            health = health - Damage;
            play("dead");
            _emitter = initBloodEmitter();
            _emitter.x = this.x;
            _emitter.y = this.y;
            _emitter.start(true, 3, 0.2);
            FlxG.state.add(_emitter as FlxBasic);
            kill();
        }
        
        /**
         * init blood emitter
         */
        private function initBloodEmitter():FlxEmitter
        {
            var emitter:FlxEmitter = new FlxEmitter(160, 30, 10);
            emitter.setXSpeed(-50, 50);
            emitter.setYSpeed(0, 100);
            emitter.bounce = .02;
            emitter.lifespan
            emitter.gravity = 30;
            
            var whitePixel:FlxParticle;
            for (var i:int = 0; i < emitter.maxSize; i++) 
            {
                whitePixel = new FlxParticle();
                whitePixel.makeGraphic(2, 2, 0xFFFF0000);
                whitePixel.visible = false; //Make sure the particle doesn't show up at (0, 0)
                emitter.add(whitePixel);
                
                whitePixel = new FlxParticle();
                whitePixel.makeGraphic(1, 1, 0xFFFF0000);
                whitePixel.visible = false;
                emitter.add(whitePixel);
            }
            return emitter;
        }
	}
}