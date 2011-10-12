package game.actors
{
	import org.flixel.FlxSprite;

	public class PlayerJumpEffect extends FlxSprite
	{
		//飞行背包的 喷气素材
		[Embed(source='../../assets/textures/effects/jump_effect.png')]
		protected var tileImg:Class;
		
		
		public function PlayerJumpEffect()
		{
			super(x,y);
			this.loadGraphic(tileImg,true,true,8,8);
			
			this.addAnimation("show",[0,1,2,3,4,5,4,3,2,1,0],24);
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