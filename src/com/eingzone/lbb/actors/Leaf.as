package com.eingzone.lbb.actors
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	public class Leaf extends FlxSprite
	{
		[Embed(source='../../../../../src/assets/textures/effects/jump_effect.png')]
		protected var tileImg:Class;
		
		private var _player:Player;
		
		
		public function Leaf(px:int,py:int)
		{
			super(px,py);
			this.loadGraphic(tileImg,true,true,8,8);
			this.acceleration.y = 0;
			this.addAnimation("show",[0,1,2,3,4,5],12);
		}
		
		public function set player(value:Player):void
		{
			_player = value;
		}

		public function playAt(x:int,y:int):void
		{
			this.reset(x,y);
			this.finished = false;
		}
		
		override public function update():void
		{
			if(FlxG.keys.P)
			{
				this.acceleration.y = 200
				this.velocity.x = 20+FlxG.random()*30;
				this.velocity.y = -200-FlxG.random()*20;
				this.play("show");
			}
			
			trace(this,"velocity y:"+this.velocity.y);
			if(this.velocity.y>0)
			{
				this.velocity.x =0;
				this.acceleration.y = 15+FlxG.random()*10;
			}
			if(this.finished)
			{
				//this.kill();
			}
			super.update();
		}
	}
}