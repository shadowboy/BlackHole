package com.eingzone.lbb.ui
{
	import com.eingzone.lbb.actors.BigRock;
	import com.eingzone.lbb.actors.Player;
	import com.eingzone.lbb.decales.Coin;
	import com.eingzone.lbb.projectiles.Bullet;
	import com.eingzone.lbb.tiles.DistantView;
	import com.eingzone.lbb.tiles.GroundView;
	import com.eingzone.lbb.tiles.MediumView;
	
	import flash.geom.Rectangle;
	
	import org.flixel.FlxButton;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxU;
	import org.flixel.system.debug.Log;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class GameState extends FlxState 
	{
		[Embed(source='../../../../../src/assets/textures/tiles/tech_tiles.png')]
		protected var tileImg:Class;
        
		private var _pauseBtn:org.flixel.FlxButton
		private var _player:Player;
		private var _bigRock:BigRock;
		private var _bullets:FlxGroup;
		private var _walls:FlxGroup;
		
		//地图块
		protected var _background:FlxGroup;
		private var _wallCount:Number = 0;
		//分数
		private var _score:int = 0;
		private var _scoreText:FlxText;
		private var _coinGroup:FlxGroup;
		
				
		public function GameState() 
		{
			super();
			
			_player =  new Player(60, 20);
			_bigRock = new BigRock(10,10);
			initState();
			
			addWalls();
			addBullets();
			
			add(_player);
			add(_bigRock);
			
			FlxG.debug=true; // enable debug console
			
			FlxG.log("test trace"); //OUTPUT: test trace
			
			FlxG.log(FlxG.width); //OUTPUT: 320 (or whatever your screen width is)
			
			var object:FlxObject = new FlxObject();
			
			addHUD();
			
			//加入可以拾取的金币
			addCoins();
		}
		
		private function addHUD():void
		{
			// TODO Auto Generated method stub
			_scoreText = new FlxText(200,10,150);
			_scoreText.size = 12
			_scoreText.scrollFactor = new FlxPoint(0,0);
			_scoreText.text = "Score:0";
			add(_scoreText);
			
			_pauseBtn = new FlxButton(10, 10, "Pause", pauseHandler);
			_pauseBtn.scrollFactor = new FlxPoint(0,0);
			add(_pauseBtn);
		}
		
		private function pauseHandler():void 
		{
			FlxG.paused = true;
		}
		
		private function addCoins():void
		{
			_coinGroup = new FlxGroup();
			var coin:Coin;
			for (var i:int = 0; i < 5; i++) 
			{
				coin = new Coin(160 + i * 30, 20);
				_coinGroup.add(coin);
			}
			add(_coinGroup);
		}
		
		private function initState():void
		{
			FlxG.camera.setBounds(0, 0, 6400, 4800);
		   
			//设置地图边界
			//边界设置，超过边界的东东即便显示，也不会进行碰撞检测等
			FlxG.worldBounds = new FlxRect(0, 0, 6400, 4800);
		}
		
		private function addBullets():void
		{
			_bullets = new FlxGroup();
			var bul:Bullet;
			for (var i:int = 0; i < 10; i++)
			{
					bul = new Bullet();
					_bullets.add(bul);
			}
			add(_bullets);
		   
			//将生成好的 bullets 放进 player 的里面
			_player.bullets = _bullets;
			trace(_bullets.length);
		}
		
		private function addWalls():void
		{
			_background = new FlxGroup();
			
			var dv:DistantView = new DistantView();
			dv.scrollFactor = new FlxPoint(0.01, 0.01);
			_background.add(dv);
			//
			var mv:MediumView = new MediumView();
			_background.add(mv);
			
			add(_background);
			
			_walls = new FlxGroup();
			
			for(var i:int=0;i<1;i++)
			{
				var g:GroundView = new GroundView();
				g.x = i*g.width+20;
				_walls.add(g);
				_wallCount++;
			}
			
			add(_walls);
		}
		
		private function createGround():void
		{
			//trace("player x:",_player.x," >_walls.length *500+10:",_wallCount *250+10);
			if(_player.x>_wallCount *320)
			{
				
				var g:GroundView = new GroundView();
				g.x = _wallCount *320+10;
				g.y = _wallCount*150;
				_walls.add(g);
				_wallCount++;
				if(_walls.length>3)
				{
					_walls.members.shift();
				}
				
				_walls.update();
				trace("walls length:",_walls.length);
			}
		}
		
		override public function update():void 
		{
			_score += FlxG.elapsed*100
			_scoreText.text = "Score:"+String(_score);
			FlxG.log("player y:"+_player.y);
			createGround();
			FlxG.worldBounds = new FlxRect((FlxG.camera.scroll.x), (FlxG.camera.scroll.y), FlxG.camera.width, FlxG.camera.height);
			
			FlxG.camera.follow(_player);
			FlxG.collide(_walls, _player);
			FlxG.collide(_walls, _bigRock);
			FlxG.collide(_bullets, _walls);
			
			FlxG.collide(_coinGroup, _walls);
			FlxG.overlap(_player, _coinGroup, getCoin);
			
			if(_player.y>(_walls.getFirstAlive() as GroundView).y+300)
			{
				//FlxG.switchState(new GameOverState());
			}
			
			super.update();
		}
		
		override public function draw():void
		{
			_walls.draw();
			super.draw();
		}
		
		private function playerOnGroundHandler(obj:FlxObject,hitObj:FlxObject):void 
		{
			//trace(obj, hitObj);
		}
		
		private function getCoin(ob1:FlxSprite,ob2:FlxSprite):void 
		{
			var coin:Coin = ob2 as Coin;
			//当金币没有被获取时，才获取金币
			if (!coin.hasGotten) 
			{
				_score += 50;
				_scoreText.text = "Score:"+String(_score);
				coin.getCoin();
			}
		}
	}
}