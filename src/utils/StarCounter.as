package utils
{
    import flash.text.TextField;

    public class StarCounter extends TextField
    {
        private var _counter:int = 0;

        public function StarCounter()
        {
            this.width = 200;
            this.selectable = false;
            this.textColor = 0xFFFFFF;
            y = 20;
        }

        public function setValue(value:int):void
        {
            _counter = value;
            this.text = "Количество звезд: " + _counter.toString();
        }

        public function append(value:int):void
        {
            _counter += value;
            this.text = "Количество звезд: " + _counter.toString();
        }
    }
}
