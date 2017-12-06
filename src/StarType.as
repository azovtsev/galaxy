package
{
    public class StarType
    {
        private var _size:int;
        private var _color:int;
        private var _chance:Number;

        public function StarType(config:XML=null)
        {
            if (config) {
                parseConfig(config);
            }
        }

        public function parseConfig(config:XML)
        {
            _size = parseInt(config.@size);
            _color = parseInt(config.@color, 16);
            _chance = parseFloat(config.@chance);
        }

        public function get size():int
        {
            return _size;
        }

        public function get color():int
        {
            return _color;
        }

        public function get chance():Number
        {
            return _chance;
        }
    }
}
