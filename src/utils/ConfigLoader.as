package utils
{
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    public class ConfigLoader extends EventDispatcher {

        public static var COMPLETE:String = "ConfigLoader.COMPLETE";
        public static var ERROR:String = "ConfigLoader.ERROR";

        private var _k : Number;
        private var _a :Number;
        private var _b : Number;
        private var _piCount : Number;

        private var _starScalePosition : Number;
        private var _starRandomPosition : Number;

        private var _sleeveCount : int;
        private var _starCount : int;

        private var _starsConfig:Vector.<StarType>;
        private var _starsCommonRand:Number = 0;

        public function ConfigLoader()
        {

        }

        public function load(url:String)
        {
            var request:URLRequest = new URLRequest(url);
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, loaderResultHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, httpRequestError);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, httpRequestError);
            try {
                loader.load(request);
            } catch (e:Error) {
                dispatchEvent(new Event(ERROR));
            }
        }


        public function get k():Number
        {
            return _k;
        }

        public function get a():Number
        {
            return _a;
        }

        public function get b():Number
        {
            return _b;
        }

        public function get scaleStarPosition():Number
        {
            return _starScalePosition;
        }

        public function get randomStarPosition():Number
        {
            return _starRandomPosition;
        }

        public function get sleeveCount():int
        {
            return _sleeveCount;
        }

        public function get piCount():Number
        {
            return _piCount;
        }

        private function loaderResultHandler(event:Event):void {
            var loader:URLLoader = event.target as URLLoader;
            loader.removeEventListener(Event.COMPLETE, loaderResultHandler);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, httpRequestError);
            loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, httpRequestError);

            var data:Object;
            try {
                data = new XML(loader.data);

                _k = Number(data.value.@k);
                _a = Number(data.value.@a);
                _b = Number(data.value.@b);
                _piCount = Number(data.value.@piCount);

                _starScalePosition = Number(data.star.@scale);
                _starRandomPosition = Number(data.star.@random);

                _sleeveCount = int(data.galaxy.@sleeve);
                _starCount = int(data.galaxy.@starCount);

                var stars:XMLList = data.stars.star;
                _starsConfig = new <StarType>[];
                for each (var x:XML in stars) {
                    var star:StarType = new StarType(x);
                    _starsConfig.push(star);
                    _starsCommonRand += star.chance;
                }
                dispatchEvent(new Event(COMPLETE));
            } catch (e:Error) {
                dispatchEvent(new Event(ERROR));
            }
        }

        private function httpRequestError(error:ErrorEvent):void
        {
            dispatchEvent(new Event(ERROR));
        }

        public function get starsConfig():Vector.<StarType>
        {
            return _starsConfig;
        }

        public function get starsCommonRand():Number
        {
            return _starsCommonRand;
        }

        public function get starCount():int
        {
            return _starCount;
        }
    }
}
