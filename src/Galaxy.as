package
{
    import flash.display.Sprite;

    public class Galaxy extends Sprite
    {
        public function Galaxy()
        {
        }

        public function drawStars(stars:Vector.<Star>):void
        {
            for each (var s:Star in stars) {
                addChild(s.getGraphics());
            }
        }
    }
}
