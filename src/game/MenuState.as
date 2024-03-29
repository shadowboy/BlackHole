package game
{
	import flash.system.Capabilities;
	
	import game.actors.Leaf;
	import game.utils.Environment;
	import game.utils.Layout;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Andy Cho
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
		[Embed(source="../assets/audio/button.mp3")]
		private var btnSound:Class;
		[Embed(source="../assets/audio/start.mp3")]
		private var startSound:Class;
		
		private var _playBtn:FlxButton;
		private var _lbBtn:FlxButton;
		private var _aboutBtn:FlxButton;
		private var _helpBtn:FlxButton;
		private var _muteBtn:FlxButton;
		
		private var theEmitter:FlxEmitter;
		private var whitePixel:FlxParticle;
		private var _info:FlxText;
		private var _btnSound:FlxSound;
		
		/**
		 * Menu state
		 * 
		 * @author Andy
		 */
		public function MenuState()
		{
			initDisplayObjects();
			FlxG.play(startSound);
		}
		
		/**
		 * Init display objects
		 */
		private function initDisplayObjects():void
		{
			var bg:FlxSprite = new FlxSprite();
			bg.loadGraphic(bgClass, false, false);
			Layout.center(bg);
			add(bg);
			
			_playBtn = new FlxButton();
			_playBtn.loadGraphic(btnPlayClass, false, false, 69, 41);
			_playBtn.soundDown = getBtnSound();
			_playBtn.x = (FlxG.width - _playBtn.width) / 2;
			_playBtn.y = FlxG.height / 3;
			_playBtn.onDown = playHandler;
			add(_playBtn);
			
			var padding:int = 10;
			_lbBtn = new FlxButton();
			_lbBtn.loadGraphic(btnLeaderBoardClass, false, false, 32, 32);
			_lbBtn.soundDown = getBtnSound();
			_lbBtn.onDown = leaderboardHandler;
			_lbBtn.x = padding;
			_lbBtn.y = FlxG.height - padding - _lbBtn.height;
			add(_lbBtn);
			
			_muteBtn = new FlxButton();
			_muteBtn.loadGraphic(btnMuteClass, false, false, 32, 32);
			_muteBtn.soundDown = getBtnSound();
			_muteBtn.onDown = optionHandler;
			_muteBtn.x = (FlxG.width - _muteBtn.width) / 2;
			_muteBtn.y = FlxG.height - _muteBtn.height - padding;
			add(_muteBtn);
			
			_aboutBtn = new FlxButton();
			_aboutBtn.loadGraphic(btnProfileClass, false, false, 32, 32);
			_aboutBtn.soundDown = getBtnSound();
			_aboutBtn.x = FlxG.width - padding - _aboutBtn.width;
			_aboutBtn.y = FlxG.height - padding - _aboutBtn.height;
			_aboutBtn.onDown = aboutHandler;
			add(_aboutBtn);
			
			_helpBtn = new FlxButton();
			_helpBtn.loadGraphic(btnHelpClass, false, false, 32, 32);
			_helpBtn.soundDown = getBtnSound();
			_helpBtn.x = FlxG.width - _helpBtn.width - padding;
			_helpBtn.y = padding;
			_helpBtn.onDown = helpHandler;
			add(_helpBtn);
			
			_info = new FlxText(0, 10, 200, "debug message");
			_info.setFormat(null, 8, 0x000000);
			_info.text = "os:" + flash.system.Capabilities.os + 
				" w:" + Capabilities.screenResolutionX + 
				" h:" + Capabilities.screenResolutionY + 
				" d:" + Environment.getInstance().device;
			add(_info);
		}
		
		/**
		 * get button sound
		 * @return
		 */
		private function getBtnSound():FlxSound
		{
			var snd:FlxSound = new FlxSound();
			snd.loadEmbedded(btnSound);
			return snd;
		}
		
		/**
		 * Go leaderboard effect
		 */
		private function leaderboardHandler():void
		{
			FlxG.fade(0xffffff, 0.5, goLeaderBoardHandler);
		}
		
		private function goPlayHandler():void
		{
			FlxG.switchState(new PlayState());
		}
		
		/**
		 * Go leaderboard
		 */
		private function goLeaderBoardHandler():void
		{
			FlxG.switchState(new LeaderboardState);
		}
		
		/**
		 * Go help handler 
		 * 
		 */        
		private function goHelpHandler():void
		{
			FlxG.switchState(new HelpState);
		}
		
		/**
		 * Go play effect
		 */
		private function playHandler():void
		{
			FlxG.fade(0x000000, 1, goPlayHandler);
		}
		
		/**
		 * Go about 
		 * 
		 */        
		private function goAboutHandler():void
		{
			FlxG.switchState(new AboutState); 
		}
		
		/**
		 * Go help effect
		 */
		private function helpHandler():void
		{
			FlxG.fade(0xffffff, 0.5, goHelpHandler);
		}
		
		/**
		 * Go about effect
		 */
		private function aboutHandler():void
		{
			FlxG.fade(0xffffff, 0.5, goAboutHandler);
		}
		
		/**
		 * Go option effect
		 */
		private function optionHandler():void
		{
			test();
		}
		
		private function test():void
		{
			theEmitter = new FlxEmitter(100, FlxG.height / 2, 30);
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
			for (var i:int = 0; i < theEmitter.maxSize; i++)
			{
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
		
		/**
		 * Test for leaf
		 */
		private function test2():void
		{
			for (var i:int = 0; i < 10; i++)
			{
				var l:Leaf = new Leaf(120 + FlxG.random() * 100, 120 + FlxG.random() * 100);
				add(l);
			}
		}
	}
}