package game.test.state
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import game.PauseState;
	import game.Registry;
	import game.Resource;
	import game.decales.Coin;
	import game.tiles.LandAbstract;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxBasic;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class TestPlayerState extends FlxState 
	{
		private var _emitter:FlxEmitter;
		private var _emitters:FlxGroup;

		private var _collisionGroup:FlxGroup;
		private var _floor:FlxSprite;
		private var _wall:FlxSprite;
		private var _curEmitterIdx:int = 0;
		private var _monster:Monster;
		
		/**
		 * 
		 */
		public function TestPlayerState() 
		{
			super();
			FlxG.mouse.show();
			
			initWall();
            
            _monster = new Monster();
            add(_monster);
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
				//_collisionGroup.add(box);
			}
			
		}
		override public function update():void 
		{
            FlxG.collide(_monster,_collisionGroup);
			super.update();
		}
	}
}