package game.tiles
{
    import game.Resource;
    import game.actors.Enemy;
    import game.decales.Coin;
    
    import org.flixel.FlxGroup;
    import org.flixel.FlxObject;
    import org.flixel.FlxTilemap;
    
    /**
     * Leve1 Land1 configration
     *  
     * @author Andy
     */    
	public class Level1Land1 extends LandAbstract
	{
		[Embed(source = "../../assets/levels/mapCSV_Level1_Map0.csv", mimeType = "application/octet-stream")] 
		public var mapCVS:Class;
		[Embed(source = "../../assets/textures/tiles/tiles.png")] 
		public var mapTilesPNG:Class;
		
		[Embed(source = "../../assets/levels/mapCSV_Level1_Star.csv", mimeType = "application/octet-stream")] 
		public var starsCVS:Class;
		[Embed(source = "../../assets/textures/decales/star.png")] 
		public var starPNG:Class;
		
		/**
		 * Construction
		 */		
		public function Level1Land1()
		{
			super();
		}
		
		/**
		 * Init maps
		 */		
        public override function initMap():void
		{
            _map = new FlxTilemap();
            _map.loadMap(new mapCVS, mapTilesPNG, 16, 16);
            _map.setTileProperties(13,FlxObject.NONE);
            _map.setTileProperties(14,FlxObject.NONE);
            _map.setTileProperties(19,FlxObject.NONE);
            _map.setTileProperties(16,FlxObject.NONE);
            _map.setTileProperties(17, FlxObject.NONE);
            _map.setTileProperties(58, FlxObject.NONE);
            _map.setTileProperties(77, FlxObject.NONE);
		}
		
		/**
		 * Init Others
		 */		
        public override function initOthers():void
		{
            parseStars();
            
            _enemies = new FlxGroup();
            //var emi:Enemy = new Enemy(_map.x + 160, _map.y + 290);
            var emi:Enemy = Resource.getEnemy();
            emi.x = _map.x + 160
            emi.y = _map.y + 290
            
            emi.map = _map;
            _enemies.add(emi);
		}
        
        //====================================================================
        
        /**
         * Parse stars
         */
        private function parseStars():void
        {
            _stars = new FlxGroup();
            _starMap = new FlxTilemap();
            _starMap.loadMap(new starsCVS, starPNG, 16, 16);
            
            for (var i:int = 0; i < _starMap.widthInTiles; i++)
            {
                for (var j:int = 0; j < _starMap.heightInTiles; j++)
                {
                    var index:int = _starMap.getTile(i, j);
                    
                    if (index == 1)
                    {
                        var coin:Coin = Resource.getCoin() as Coin;
                        coin.showCoin(_map.x + i * 16, _map.y + j * 16);
                        _stars.add(coin);
                    }
                    else if(index == 2)
                    {
                        
                    }
                }
            }
        }
        
	}
}