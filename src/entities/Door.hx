package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Door extends Entity implements IActionable
{
    public function new(x:Float, y:Float) {
        super(x, y);
        var sprite = Image.createRect(48, 64, 0x000000);
        sprite.originX = 24;
        sprite.originY = 64;
        graphic = sprite;

        setHitbox(48, 64, 24, 64);
    }

    public function canAction(player:Player) {
        return (collide('player', x, y) != null);
    }

    public function executeAction(player:Player) {
        // travel dimensions
        scene.remove(this);
    }
}
