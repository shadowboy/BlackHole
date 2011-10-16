package game.actors
{
	import org.flixel.FlxSprite;

	public class PlayerDownEffect extends FlxSprite
	{
		//飞行背包的 喷气素材
		[Embed(source='../../assets/textures/effects/down_dusty.png')]
		protected var tileImg:Class;
		
		
		public function PlayerDownEffect()
		{
			super(x,y);
			this.loadGraphic(tileImg,true,false,50,20);
			this.addAnimation("show",[0,1,2,3,4,5,6,7,8],24,false);
		}
		
		public function playAt(x:int,y:int):void
		{
			this.reset(x,y);
			this.finished = false;
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