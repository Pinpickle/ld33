package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Wall extends Entity {
    public function new(x:Float, y:Float, width:Int = 24, height:Int = 24) {
        super(x, y);
        graphic = Image.createRect(width, height, 0xFFFFFF);
        setHitbox(width, height);
        type = 'solid';
    }
}
