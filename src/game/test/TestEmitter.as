package game.test
{
	import com.bit101.components.HScrollBar;
	import com.bit101.components.HUISlider;
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
	public class TestEmitter extends FlxState 
	{
		private var _emitter:FlxEmitter;
		private var _lifeSlider:HUISlider;
		private var _frequencySlider:HUISlider;
		protected var _bg:FlxSprite;
		
		protected var _titleField:FlxText;
		protected var _introField:FlxText;
		protected var _backBtn:FlxButton;
		
		public function TestEmitter() 
		{
			super();
			FlxG.mouse.show();
			
			_emitter = initWindEmitter();
			this.add(_emitter);
			
			_lifeSlider = new HUISlider(FlxG.stage, 10, 20, "LIFE:", changeLifeTimeHandler);
			_lifeSlider.maximum = 5;
			_lifeSlider.minimum = 0;
			_lifeSlider.width = 300;
			_lifeSlider.value = 4;
			
			_frequencySlider = new HUISlider(FlxG.stage, 10, 40, "frequency:", changeFrequencyHandler);
			_frequencySlider.maximum = 2;
			_frequencySlider.minimum = 0;
			_frequencySlider.width = 300;
			_frequencySlider.value = 0.5;
			
			//1.6 0.2
			
		}
		
		private function changeFrequencyHandler(e:Event):void 
		{
			_emitter.start(false, _lifeSlider.value, _frequencySlider.value);
		}
		
		private function changeLifeTimeHandler(e:Event):void 
		{
			_emitter.start(false, _lifeSlider.value, 0.1);
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