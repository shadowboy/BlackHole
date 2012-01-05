package game.components 
{
	import game.projectiles.Bullet;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Andy
	 */
	public class BulletsCache 
	{
		public var bullets:FlxGroup;
		private var _curBulletIdx:int;
		
		static private var _instance:BulletsCache;
		
		/**
		 * 
		 */
		public function BulletsCache() 
		{
			bullets = new FlxGroup();
			var bul:Bullet;
			for (var i:int = 0; i < 5; i++)
			{
				bul = new Bullet();
				bullets.add(bul);
			}
		}
		
		/**
		 * 
		 * 
		 */
		public function getInstance():void
		{
			if (_instance == null)
				_instance = new BulletsCache();
			return _instance;
		}
		
		/**
		 * get bullets
		 * @return
		 */
		public static function getBullet():Bullet
		{
			if (_curBulletIdx >= bullets.length - 1)
			{
				_curBulletIdx = 0;
			}
			else
			{
				_curBulletIdx++;
			}
			return bullets.members[_curBulletIdx] as Bullet;
		}
		
		/**
		 * 
		 * @param	position
		 * @param	bulletType
		 */
		public function shootBullet(position:FlxPoint, bulletType:String)
		{
			getBullet().shoot(position, bulletType);
		}
	}

}