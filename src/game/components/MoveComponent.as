package game.components 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	/**
	 * ...
	 * @author Andy
	 */
	public class MoveComponent 
	{
		private var _actor:FlxSprite;
		private var _map:FlxTilemap;
		
		public function MoveComponent(actor:FlxSprite,map:FlxTilemap) 
		{
			_actor = actor;
			_map = map;
		}
		
		/**
		 * 
		 */
		public function moveOnGround():void
		{
			var tx:int = Math.round((_actor.x-_map.x) / 16);
            var ty:int = Math.round((_actor.y-_map.y) / 16);
            
//            trace("ty:"+ty);
//            trace("ty-1:",_map.getTile(tx+1,ty-1));
//            trace("ty:",_map.getTile(tx+1,ty));
//            trace("ty+1:",_map.getTile(tx+1,ty+1));
//            
            if (_actor.facing == FlxObject.LEFT)
            {
                if (_map.getTile(tx - 1, ty) > 0)
                {
                    //如果前方有障碍就转头
                    turnAround();
                }
                else if(_map.getTile(tx-1,ty+1)<=0 && _actor.isTouching(FlxObject.FLOOR))
                {
                    //如果在地面行走的时候发现前方左下角为空时回头
                    turnAround(); 
                }
                    
            }
            else
            {
                if (_map.getTile(tx+1, ty) >0)
                {
                    turnAround();
                }
                else if(_map.getTile(tx+1,ty+1)<=0 && _actor.isTouching(FlxObject.FLOOR))
                {
                    turnAround();
                }
            }
		}
		
		private function turnAround():void
        {
            if (_actor.facing == FlxObject.RIGHT)
            {
                _actor.facing = FlxObject.LEFT;
                _actor.velocity.x = -30;
            }
            else
            {
                _actor.facing = FlxObject.RIGHT;
                _actor.velocity.x = 30;
            }
        }
	}
}