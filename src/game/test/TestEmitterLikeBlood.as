package game.test
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	
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
		private var _bg:FlxSprite;
		
		private var _titleField:FlxText;
		private var _introField:FlxText;
		private var _backBtn:FlxButton;
		private var collisionGroup:FlxGroup;
		private var floor:FlxSprite;
		private var wall:FlxSprite;
		
		public function TestEmitterLikeBlood() 
		{
			super();
			FlxG.mouse.show();
			
			collisionGroup = new FlxGroup();
			wall= new FlxSprite(100, 100);
			wall.makeGraphic(10, 100, 0x50FFFFFF);//Make it darker - easier on the eyes :)
			wall.visible = wall.solid = true;//Set both the visibility AND the solidity to false, in one go
			wall.immovable = true;//Lets make sure the pixels don't push out wall away! (though it does look funny)
			collisionGroup.add(wall);
			
			//Duplicate our wall but this time it's a floor to catch gravity affected particles
			floor = new FlxSprite(0, 120);
			floor.makeGraphic(FlxG.width, 10, 0x50FFFFFF);
			floor.visible = floor.solid = true;
			floor.immovable = true;
			collisionGroup.add(floor);
			
			add(collisionGroup);
			
			var len:int = 8;
			for (var i:int = 0; i < len; i++) 
			{
				var box:FlxSprite = new FlxSprite(Math.random()*100, Math.random()*200);
				box.makeGraphic(5, 5, 0xffffcc00);
				box.visible = floor.solid = true;
				box.immovable = true;
				collisionGroup.add(box);
			}
			
			_emitter = initBloodEmitter();
			_emitter.start(true, 1.6, 0.2);
			this.add(_emitter);
			
		}
		
		/**
		 * 
		 */
		private function initBloodEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter(160, 30, 30);
			emitter.setXSpeed(-100, -50);
			emitter.setYSpeed(0, 100);
			emitter.bounce = .02;
			
			emitter.gravity = 20;
			var whitePixel:FlxParticle;
			for (var i:int = 0; i < emitter.maxSize; i++) 
			{
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(2, 2, 0xFFFFFFFF);
				whitePixel.visible = false; //Make sure the particle doesn't show up at (0, 0)
				emitter.add(whitePixel);
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(1, 1, 0xFFFFFFFF);
				whitePixel.visible = false;
				emitter.add(whitePixel);
			}
			return emitter;
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.collide(_emitter, collisionGroup);
		}
	}
}