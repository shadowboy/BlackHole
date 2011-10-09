package com.eingzone.lbb.decales
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author zb
	 */
	public class Coin extends FlxSprite 
	{
		//金币素材
		[Embed(source = '../../../../../src/assets/textures/decales/coin.png')]
		protected var coinImg:Class;
		//拾取金币时的音效
		[Embed(source = '../../../../../src/assets/audio/decales/pickup.mp3')]
		protected var getSnd:Class;
		protected var _score:FlxText;
		//金币是否已经被拾取的 标识
		public var hasGotten:Boolean = false;
		
		/**
		 * 
		 * @param px
		 * @param py
		 * 
		 */		
		public function Coin():void 
		{
			loadGraphic(coinImg, true, false, 8, 8);
			//设置coin的坐标
			//这里 y 坐标向上移动一个 coin 的高度，
			//主要是方便 如果将coin 直接放在平台上时不会与平台重叠
			
			//金币动画
			addAnimation('roll', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 12);
			
			//给金币一个 y 轴方向的加速度以及最大速度
			//因为本教程是让金币从高空中落下
			
			_score = new FlxText(this.x,this.y,30,"+50");
		}
		
		public function showCoin(px:int,py:int):void
		{
			this.reset(px,py);
			
			acceleration.y = 300;
			maxVelocity.y = 300;
			
			hasGotten = false;
			this.finished = false;
			play('roll');
		}
		
		//获取金币时的方法
		public function getCoin():void 
		{
			//获取金币时 设置为 true
			hasGotten = true;
			this.velocity.y = -0.5 * this.acceleration.y;
			FlxG.play(getSnd);
			FlxG.state.add(_score);
		}
		
		//重写 update
		override public function update():void 
		{
			//这里判断 当 y 速度大于50，同时已经被 获取时
			//也就是在金币 被 player 获取后，在弹起下落过程时
			if (velocity.y>=50 && hasGotten) 
			{
				//将金币 kill 掉
				FlxG.score+=50;
				this.kill();
			}
			//别忘了
			super.update();
		}
	}
	
}