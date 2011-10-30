package game
{
    import org.flixel.FlxG;
    import org.flixel.FlxSprite;

    public class Layout
    {
        public function Layout()
        {
        }
        
        public static function center(obj:FlxSprite):void
        {
            obj.x = (FlxG.width - obj.width)/2;
            obj.y = (FlxG.height - obj.height)/2;
        }
    }
}