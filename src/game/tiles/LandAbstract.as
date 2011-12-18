package game.tiles 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	import org.hamcrest.mxml.object.Null;
	import org.hamcrest.object.nullValue;
	
	/**
	 * ...
	 * @author Andy
	 */
	public class LandAbstract extends FlxGroup 
	{
		protected var _map:FlxTilemap;
		protected var _starMap:FlxTilemap;
		protected var _stars:FlxGroup;
		protected var _enemies:FlxGroup;
		
		//properties
		protected var _width:int;
		protected var _height:int;
		protected var _x:int;
		protected var _y:int;
		
		/**
		 * Construction
		 */
		public function LandAbstract() 
		{
			initMap();
		}
		
		/**
		 *  
		 * @return 
		 * 
		 */		
		public function get width():int 
		{
			return _map.width;
		}
		
		public function get height():int 
		{
			return _map.height;
		}
		
		public function get x():int 
		{
			return _map.x;
		}
		
		public function set x(value:int):void 
		{
			_x = value;
			_map.x = _x;
		}
		
		public function get y():int 
		{
			return _map.y;
		}
		
		public function set y(value:int):void 
		{
			_y = value;
			_map.y = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
        public function get map():FlxTilemap
        {
            return _map;
        }
        
		public function get rewards():FlxGroup 
		{
			return _stars;
		}
        
        public function get enemies():FlxGroup
        {
            return _enemies;
        }
		
		/**
		 * Init map 
		 * 
		 */		
		public function initMap():void
		{
			
		}
        
        /**
         * Init Other 
		 * Such as rewards enemies
         * 
         */        
		public function initOthers():void
		{

		}
        
        override public function destroy():void
        {
            super.destroy();
            _map.destroy();
            _map = null;
            _stars.destroy();
            _stars = null;
            _enemies.destroy();
            _enemies = null;
        }
	}
}