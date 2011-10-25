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
		[Embed(source="../assets/textures/ui/scene_menu_bg.png")]
		private var bgClass:Class;
        
        [Embed(source="../assets/textures/ui/btn_mute.png")]
        private var btnMuteClass:Class;
        
        [Embed(source="../assets/textures/ui/btn_profile.png")]
        private var btnProfileClass:Class;
        
        [Embed(source="../assets/textures/ui/btn_leaderboard.png")]
        private var btnLeaderBoardClass:Class;
        
        [Embed(source="../assets/textures/ui/btn_help.png")]
        private var btnHelpClass:Class;
        
        [Embed(source="../assets/textures/ui/btn_play.png")]
        private var btnPlayClass:Class;
		
		private var _playBtn:FlxButton;
		private var _lbBtn:FlxButton;
		private var _aboutBtn:FlxButton;
		private var _helpBtn:FlxButton;
		private var _muteBtn:FlxButton;
		
		private var theEmitter:FlxEmitter;
		private var whitePixel:FlxParticle;
		
		public function MenuState() 
		{
			FlxG.mouse.show();
			
			var bg:FlxSprite = new FlxSprite();
			bg.loadGraphic(bgClass, false, false, FlxG.width, FlxG.height);
			add(bg);
			
			_playBtn = new FlxButton();
            _playBtn.loadGraphic(btnPlayClass,false,false,69,41);
			_playBtn.x = (FlxG.width - _playBtn.width)/2;
			_playBtn.y = FlxG.height/3;
            _playBtn.onDown = playHandler;
			add(_playBtn);
			
            var padding:int = 10;
			_lbBtn = new FlxButton();
            _lbBtn.loadGraphic(btnLeaderBoardClass,false,false,32,32);
            _lbBtn.onDown = leaderboardHandler;
			_lbBtn.x = padding;
			_lbBtn.y = FlxG.height-padding-_lbBtn.height;
			add(_lbBtn);
			
            _muteBtn = new FlxButton();
            _muteBtn.loadGraphic(btnMuteClass,false,false,32,32);
            _muteBtn.onDown = optionHandler;
            _muteBtn.x = (FlxG.width - _muteBtn.width)/2;
            _muteBtn.y = FlxG.height-_muteBtn.height-padding;
            add(_muteBtn);
            
			_aboutBtn = new FlxButton();
            _aboutBtn.loadGraphic(btnProfileClass,false,false,32,32);
			_aboutBtn.x = FlxG.width - padding - _aboutBtn.width;
			_aboutBtn.y = FlxG.height - padding - _aboutBtn.height;
            _aboutBtn.onDown = aboutHandler;
			add(_aboutBtn);
			
			_helpBtn = new FlxButton();
            _helpBtn.loadGraphic(btnHelpClass,false,false,32,32);
			_helpBtn.x = FlxG.width - _helpBtn.width-padding;
			_helpBtn.y = padding;
            _helpBtn.onDown = helpHandler;
			add(_helpBtn);
			
            
		}
        
        private function leaderboardHandler():void
        {
            FlxG.switchState(new LeaderboardState);
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