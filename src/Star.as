package
{
    import flash.display.Shape;

    public class Star
    {
        private var _type:StarType;
        private var _x:int;
        private var _y:int;

        public function Star(type:StarType, x:int, y:int)
        {
            _type = type;
            _x = x;
            _y = y;
        }

        public function getGraphics():Shape
        {
            var s:Shape = new Shape();
            s.graphics.beginFill(_type.color);
            s.graphics.drawCircle(0, 0, _type.size);
            s.graphics.endFill();

            s.x = _x;
            s.y = _y;

            return s;
        }
    }
}
