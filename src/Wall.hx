import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Wall extends Entity {
    public function new(x:Float, y:Float) {
        super(x, y);
        graphic = Image.createRect(24, 24, 0xFFFFFF);
        setHitbox(24, 24);
        type = 'solid';
    }
}
