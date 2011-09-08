package com.eingzone.lbb.ui
{
	import com.eingzone.lbb.actors.Player;
	import com.eingzone.lbb.projectiles.Bullet;
	
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
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class GameState extends FlxState 
	{
		[Embed(source='assets/textures/tiles/tech_tiles.png')]
		protected var tileImg:Class;
                
		private var _player:Player;
		private var _bullets:FlxGroup;
		private var _walls:FlxGroup;
		private var _scoreField:FlxText;
		
		//地图块
		protected var _ground:FlxTileblock;
		
				
		public function GameState() 
		{
			super();
			
			_player =  new Player(20, 20);
			add(_player);
			
			
			
			initState();
			addBullets();
			addWalls();
			
			_scoreField = new FlxText(200,10,200,"Score:100",true);
			_scoreField.scrollFactor.x = _scoreField.scrollFactor.y = 0;
			add(_scoreField);
		}
		
		private function initState():void
		{
			FlxG.camera.setBounds(0, 0, 640, 480);
		   
			//设置地图边界
			//边界设置，超过边界的东东即便显示，也不会进行碰撞检测等
			FlxG.worldBounds = new FlxRect(0, 0, 640, 480);
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
			_walls = new FlxGroup();
			_ground = new FlxTileblock(0, 230, 640, 10);
			_ground.loadTiles(tileImg);
			_walls.add(_ground);
			
			
			var wall:FlxTileblock;
			for (var i:int = 0; i < 5; i++) 
			{
				wall = new FlxTileblock(150+i*10,240-(i*20+10),20,10);
				wall.loadGraphic(tileImg)
				_walls.add(wall);
			}
			add(_walls);
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.camera.follow(_player,FlxCamera.STYLE_TOPDOWN);
			FlxG.collide(_ground, _player, playerOnGroundHandler);
			FlxG.collide(_walls, _player);
			FlxG.collide(_bullets, _walls,onBulletHitWallHandler);
		}
		
		private function onBulletHitWallHandler(obj:FlxObject,hitObj:FlxObject):void
		{
			// TODO Auto Generated method stub
			trace(obj, hitObj);
			(obj as Bullet).hurt(1);
		}
		
		private function playerOnGroundHandler(obj:FlxObject,hitObj:FlxObject):void 
		{
			//trace(obj, hitObj);
		}
		
	}

}