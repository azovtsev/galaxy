package
{
    import utils.ConfigLoader;

    public class Generators
    {
        public function Generators()
        {
        }

        public static function generationStar(countStar:int, config:ConfigLoader):Vector.<Star>
        {
            var result:Vector.<Star> = new <Star>[];

            var h, k, r:Number;
            var x, y :int;

            var pi:Number = config.piCount * Math.PI;

            k = config.k;
            h = (pi - k) / countStar * config.sleeveCount;

            var step:Number = 2 * Math.PI / config.sleeveCount;

            for (var i:int = 1; i <= config.sleeveCount; i++) {
                k = config.k;

                do {
                    r = config.a * Math.exp(k * config.b);
                    x = ((r * Math.cos(k)) + (Math.random() * config.randomStarPosition)) * config.scaleStarPosition;
                    y = ((-r * Math.sin(k)) + (Math.random() * config.randomStarPosition)) * config.scaleStarPosition;

                    if (config.sleeveCount > 1) {

                        var xOld:Number = x;
                        var cos:Number = Math.cos(step * i);
                        var sin:Number = Math.sin(step * i);
                        var random5:Number = config.randomStarPosition * 5;

                        x = random5 + (xOld - random5) * cos - (random5 - y) * sin;
                        y = random5 + (xOld - random5) * sin + (random5 - y) * cos;
                    }

                    var chance:Number = Math.random();
                    var currentChance:Number = 0;
                    var currentType:StarType = config.starsConfig[0];

                    for each (var star:StarType in config.starsConfig) {
                        currentChance += star.chance / config.starsCommonRand;
                        if (chance <= currentChance) {
                            currentType = star;
                            break;
                        }
                    }

                    result.push(new Star(currentType, x, y));

                    k = k + h;
                } while (k < pi);
            }
            return result;
        }
    }
}
