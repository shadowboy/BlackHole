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
	import game.tiles.LandAbstract;
	
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
	public class TestEmitterLikeWind extends FlxState 
	{
		private var _emitter:FlxEmitter;
		private var _bg:FlxSprite;
		
		private var _titleField:FlxText;
		private var _introField:FlxText;
		private var _backBtn:FlxButton;
		
		public function TestEmitterLikeWind() 
		{
			super();
			FlxG.mouse.show();
			
			_emitter = initWindEmitter();
			_emitter.start(false, 1.6, 0.2);
			this.add(_emitter);
			
		}
		
		/**
		 * 
		 */
		private function initWindEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter(160, 30, 100);
			emitter.setXSpeed(-100, -50);
			emitter.setYSpeed(0, 100);
			emitter.bounce = .8;
			
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
	}
}