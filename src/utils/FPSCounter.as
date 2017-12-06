package utils {

    import flash.events.Event;
    import flash.text.TextField;
    import flash.utils.getTimer;

    public class FPSCounter extends TextField
    {
        private var _startTime:Number = getTimer();
        private var _framesNumber:Number = 0;

        public function FPSCounter()
        {
            this.selectable = false;
            this.textColor = 0xFFFFFF;

            addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }


        private function enterFrameHandler(event:Event):void {
            var currentTime:Number = (getTimer() - _startTime) / 1000;

            _framesNumber++;

            if (currentTime > 1)
            {
                this.text = "FPS: " + Math.floor(_framesNumber/currentTime);
                _startTime = getTimer();
                _framesNumber = 0;
            }
        }
    }
}
