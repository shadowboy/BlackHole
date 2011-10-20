package game
{
	import org.flixel.*;
	
	public class Registry 
	{
		public static var map:FlxTilemap;
		public static var levelExit:FlxPoint;
		public static var bullets:FlxGroup;
		public static var emitters:FlxEmitter;
		static public var paused:Boolean;
		
		public function Registry() 
		{
		}
		
	}

}