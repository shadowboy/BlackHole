package game.actors
{
	import org.flixel.FlxSprite;

	public class PlayerJumpEffectSecond extends FlxSprite
	{
		//飞行背包的 喷气素材
		[Embed(source='../../assets/textures/effects/jump_effect2.png')]
		protected var tileImg:Class;
		
		
		public function PlayerJumpEffectSecond()
		{
			super(x,y);
			this.loadGraphic(tileImg,true,false,60,60);
			
			this.addAnimation("show",[0,1,2,3,4],12,false);
		}
		
		public function playAt(x:int,y:int):void
		{
			this.finished = false;
			this.reset(x,y);
			this.play("show",true);
			
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