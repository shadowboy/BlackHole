package game
{
	import game.actors.Leaf;
	import game.tiles.Level1;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class MenuState extends FlxState 
	{
		[Embed(source="../assets/textures/ui/4345441923_305fbde3a7.jpg")]
		private var bgClass:Class;
		
		private var _playBtn:FlxButton;
		private var _optionBtn:FlxButton;
		private var _aboutBtn:FlxButton;
		private var _helpBtn:FlxButton;
		
		private var theEmitter:FlxEmitter;
		private var whitePixel:FlxParticle;
		
		public function MenuState() 
		{
			FlxG.mouse.show();
			
			var bg:FlxSprite = new FlxSprite();
			bg.loadGraphic(bgClass, false, false, FlxG.width, FlxG.height);
			//add(bg);
			
			var cx:int = (FlxG.width-80)/2;
			var sy:int = int(FlxG.height/5*2);
			var step:int = 20;
			
			_playBtn = new FlxButton(0, 0, "play", playHandler);
			_playBtn.x = cx;
			_playBtn.y = sy;
			add(_playBtn);
			
			sy+= step;
			
			_optionBtn = new FlxButton(0, 0, "option", optionHandler);
			_optionBtn.x = cx;
			_optionBtn.y = sy;
			add(_optionBtn);
			
			sy+= step;
			
			_aboutBtn = new FlxButton(0, 0, "about", aboutHandler);
			_aboutBtn.x = cx;
			_aboutBtn.y = sy;
			add(_aboutBtn);
			
			sy+= step;
			
			_helpBtn = new FlxButton(100, 160, "help", helpHandler);
			_helpBtn.x = cx;
			_helpBtn.y = sy;
			add(_helpBtn);
			
		}
		
		private function playHandler():void 
		{
			FlxG.switchState(new PlayState);
		}
		
		private function helpHandler():void 
		{
			FlxG.switchState(new HelpState);
		}
		
		private function aboutHandler():void 
		{
			FlxG.switchState(new AboutState);
		}
		
		private function optionHandler():void 
		{
			//FlxG.switchState(new OptionState);
			test();
		}
		
		private function test():void
		{
			theEmitter = new FlxEmitter(100, FlxG.height / 2, 30);
			
			//Now by default the emitter is going to have some properties set on it and can be used immediately
			//but we're going to change a few things.
			
			//First this emitter is on the side of the screen, and we want to show off the movement of the particles
			//so lets make them launch to the right.
			theEmitter.setXSpeed(-50, 50);
			
			//and lets funnel it a tad
			theEmitter.setYSpeed(-50, 50);
			
			//Let's also make our pixels rebound off surfaces
			theEmitter.bounce = .8;
			
			theEmitter.gravity = 100;
			//Now let's add the emitter to the state.
			add(theEmitter);
			
			//Now it's almost ready to use, but first we need to give it some pixels to spit out!
			//Lets fill the emitter with some white pixels
			for (var i:int = 0; i < theEmitter.maxSize; i++) {
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(2, 2, 0xFFFFFFFF);
				whitePixel.visible = false; //Make sure the particle doesn't show up at (0, 0)
				theEmitter.add(whitePixel);
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(1, 1, 0xFFFFFFFF);
				whitePixel.visible = false;
				theEmitter.add(whitePixel);
			}
			
			theEmitter.start(true, 1, .01);
		}
		
		private function test2():void
		{
			for(var i:int=0;i<10;i++)
			{
				var l:Leaf = new Leaf(120+FlxG.random()*100,120+FlxG.random()*100);
				add(l);
			}
			
		}
	}
}