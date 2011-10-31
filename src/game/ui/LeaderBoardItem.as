package game.ui 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class LeaderBoardItem extends FlxGroup
	{
		[Embed(source = '../../assets/textures/ui/leader_board_face.png')]
		protected static var faceImg:Class;
		
		private var _face:FlxSprite;
		private var _name:FlxText;
		private var _score:FlxText;
		private var _padding:int = 2;
		
		private var _x:int = 0;
		private var _y:int = 0;
		private var _width:int;
		private var _height:int;
		
		/**
		 * construction
		 */
		public function LeaderBoardItem() 
		{
			_face = new FlxSprite();
			_face.loadGraphic(faceImg);
			add(_face);
			
			_name = new FlxText(0, 0, 120, "default name");
			_name.setFormat(null, 8, 0x00000000);
			add(_name);
			
			_score = new FlxText(0, 0, 120,"default score");
			_score.setFormat(null, 8, 0x00000000);
			add(_score);
			//drawLayout();
		}
		
		/**
		 * draw layout
		 */
		private function drawLayout():void
		{
			_face.x = _x;
			_face.y = _y;
			
			_name.x = _face.x + _face.width + _padding;
			_name.y = _y;
			
			_score.x = _face.x + _face.width + _padding;
			_score.y = _y +10
			trace(_score.y);
		}
		
		/**
		 * x
		 */
		public function get x():int 
		{
			return _x;
		}
		public function set x(value:int):void 
		{
			_x = value;
			drawLayout();
		}
		
		/**
		 * y
		 */
		public function get y():int 
		{
			return _y;
		}
		public function set y(value:int):void 
		{
			_y = value;
			drawLayout();
		}
		
		/**
		 * width
		 */
		public function get width():int 
		{
			return _width;
		}
		public function set width(value:int):void 
		{
			_width = value;
		}
		
		/**
		 * height
		 */
		public function get height():int 
		{
			return _height;
		}
		public function set height(value:int):void 
		{
			_height = value;
		}
		
		/**
		 * name
		 */
		public function set name(name:String):void 
		{
			_name.text = name;
		}
		
		/**
		 * score
		 */
		public function set score(value:int):void 
		{
			_score.text = value.toString();
		}
	}
}