package game.test
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	
	import game.PauseState;
	import game.Registry;
	import game.Resource;
	import game.decales.Coin;
	import game.tiles.LevelBase;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class TestEmitterLikeBlood extends FlxState 
	{
		private var _emitter:FlxEmitter;
		private var _emitters:FlxGroup;

		private var _collisionGroup:FlxGroup;
		private var _floor:FlxSprite;
		private var _wall:FlxSprite;
		private var _curEmitterIdx:int = 0;
		
		/**
		 * 
		 */
		public function TestEmitterLikeBlood() 
		{
			super();
			FlxG.mouse.show();
			
			initWall();
			initEmitter();
		}
		
		/**
		 * init wall
		 */
		private function initWall():void
		{
			_collisionGroup = new FlxGroup();
			_wall= new FlxSprite(100, 100);
			_wall.makeGraphic(10, 100, 0x50FFFFFF);//Make it darker - easier on the eyes :)
			_wall.visible = _wall.solid = true;//Set both the visibility AND the solidity to false, in one go
			_wall.immovable = true;//Lets make sure the pixels don't push out _wall away! (though it does look funny)
			_collisionGroup.add(_wall);
			
			//Duplicate our _wall but this time it's a _floor to catch gravity affected particles
			_floor = new FlxSprite(0, FlxG.height-10);
			_floor.makeGraphic(FlxG.width, 10, 0x50FFFFFF);
			_floor.visible = _floor.solid = true;
			_floor.immovable = true;
			_collisionGroup.add(_floor);
			
			add(_collisionGroup);
			
			var len:int = 8;
			for (var i:int = 0; i < len; i++) 
			{
				var box:FlxSprite = new FlxSprite(Math.random()*100, Math.random()*200);
				box.makeGraphic(5, 5, 0xffffcc00);
				box.visible = _floor.solid = true;
				box.immovable = true;
				_collisionGroup.add(box);
			}
			
		}
		
		/**
		 * init emitter
		 */
		private function initEmitter():void
		{
			_emitters = new FlxGroup();
			var len:int = 5;
			for (var i:int = 0; i < len; i++) 
			{
				_emitters.add(initBloodEmitter());
			}
		}
		
		/**
		 * get emitter
		 * @return
		 */
		private function getEmitter():FlxEmitter
		{
			if (_curEmitterIdx >= _emitters.length-1)
            {
                _curEmitterIdx = 0;
            }
            else
            {
                _curEmitterIdx++;
            }
            return _emitters.members[_curEmitterIdx] as FlxEmitter;
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
		
		override public function update():void 
		{
			if (FlxG.mouse.justPressed())
			{
				var p:FlxPoint = FlxG.mouse.getScreenPosition(); 
				
				_emitter = getEmitter();
				_emitter.x = p.x;
				_emitter.y = p.y;
				_emitter.start(true, 3, 0.2);
				this.add(_emitter);
			}
			super.update();
			FlxG.collide(_emitters, _collisionGroup);
		}
	}
}