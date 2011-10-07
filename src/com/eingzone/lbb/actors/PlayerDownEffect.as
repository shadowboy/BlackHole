package com.eingzone.lbb.actors
{
	import org.flixel.FlxSprite;

	public class PlayerDownEffect extends FlxSprite
	{
		//飞行背包的 喷气素材
		[Embed(source='../../../../../src/assets/textures/effects/jump_down.png')]
		protected var tileImg:Class;
		
		
		public function PlayerDownEffect()
		{
			super(x,y);
			this.loadGraphic(tileImg,true,true,16,16);
			this.addAnimation("show",[0,1,2,3,4,5],24);
		}
		
		public function playAt(x:int,y:int):void
		{
			this.reset(x,y);
			this.finished = false;
			this.play("show");
		}
		
		override public function update():void
		{
			if(this.finished)
			{
				this.kill();
			}
			super.update();
		}
	}
}