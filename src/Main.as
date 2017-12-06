package
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.geom.Rectangle;
    import flash.text.TextField;

    import utils.ConfigLoader;
    import utils.FPSCounter;
    import utils.StarCounter;

    [SWF(backgroundColor="0x00000")]
    public class Main extends Sprite
    {
        private var galaxy:Galaxy;
        private var config:ConfigLoader;
        private var currentScale:Number = 0.4;
        private var starCounter:StarCounter;

        public function Main()
        {
            this.stage.scaleMode = StageScaleMode.NO_SCALE;
            this.stage.align = StageAlign.TOP_LEFT;

            var textField:TextField = new TextField();
            textField.y = 40;
            textField.width = 300;
            textField.selectable = false;
            textField.textColor = 0xFFFFFF;
            textField.text = "Управление:\nМасштаб: Page up, Page down\nПеремещение: стрелки\nДобавить 1000 звезд: Z\n" +
                    "Добавить 10000 звезд: X\nУдалить все звезды: C";
            addChild(textField);

            addChild(new FPSCounter());
            starCounter = new StarCounter();
            addChild(starCounter);

            galaxy = new Galaxy();
            galaxy.scaleX = currentScale;
            galaxy.scaleY = currentScale;
            addChild(galaxy);

            if (stage) {
                addedToStageHandler(null);
            } else {
                addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            }
        }

        private function addedToStageHandler(event:Event):void
        {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            config = new ConfigLoader();
            config.addEventListener(ConfigLoader.COMPLETE, configCompleteHandler);
            config.addEventListener(ConfigLoader.ERROR, configErrorHandler);
            config.load("config.xml");
        }

        private function configCompleteHandler(event:Event):void
        {
            var stars:Vector.<Star> = Generators.generationStar(config.starCount,config);
            starCounter.setValue(stars.length);
            galaxy.drawStars(stars);

            var bounds:Rectangle = getBounds(galaxy);
            galaxy.x = -bounds.x * currentScale;
            galaxy.y = -bounds.y * currentScale;
        }

        private function configErrorHandler(event:Event):void
        {
            var textField:TextField = new TextField();
            textField.y = 130;
            textField.width = 300;
            textField.selectable = false;
            textField.textColor = 0xFF0000;
            textField.text = "Ошибка загрузки config.xml";
            addChild(textField);
        }

        private function keyDownHandler(event:KeyboardEvent):void
        {
            switch (event.keyCode) {
                case 37: //left
                    galaxy.x += 10;
                    break;
                case 38: //up
                    galaxy.y += 10;
                    break;
                case 39: //right
                    galaxy.x -= 10;
                    break;
                case 40: //down
                    galaxy.y -= 10;
                    break;
                case 33: //page up
                    currentScale -= 0.1;
                    if (currentScale < 0.1) currentScale = 0.1;

                    galaxy.scaleX = currentScale;
                    galaxy.scaleY = currentScale;
                    break;
                case 34: //page down
                    currentScale += 0.1;
                    galaxy.scaleX = currentScale;
                    galaxy.scaleY = currentScale;
                    break;
                case 90: //z
                    var stars:Vector.<Star> = Generators.generationStar(1000,config);
                    starCounter.append(stars.length);
                    galaxy.drawStars(stars);
                    break;
                case 88: //x
                    stars = Generators.generationStar(10000,config);
                    starCounter.append(stars.length);
                    galaxy.drawStars(stars);
                    break;
                case 67: //c
                    galaxy.removeChildren();
                    starCounter.setValue(0);
                    break;
            }
        }
    }
}
