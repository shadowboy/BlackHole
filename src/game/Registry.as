package game
{
	import game.decales.Coin;
	
	import org.flixel.*;
	
	public class Registry 
	{
		public static var map:FlxTilemap;
		public static var levelExit:FlxPoint;
		public static var bullets:FlxGroup;
		public static var emitters:FlxEmitter;
		static public var paused:Boolean;
		public static var stars:FlxGroup;
		private static var _curIndex:int = 0;
		
		public function Registry() 
		{
		}
        
        
        public static function getCoin():Coin
        {
            if (_curIndex >= stars.length-1)
            {
                _curIndex = 0;
            }
            else
            {
                _curIndex++;
            }
            return stars.members[_curIndex] as Coin;
        }
		
	}

}