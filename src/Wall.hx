import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Wall extends Entity {
    public function new(x:Float, y:Float) {
        graphic = Image.createRect(24, 24, 0xFFFFFF);
        super(x, y);
    }
}
