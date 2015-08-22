package entities;

import com.haxepunk.masks.Circle;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class EnergyBall extends Entity {
    public function new(x:Float, y:Float) {
        super(x, y);

        originX = 10;
        originY = 10;
        mask = new Circle(10, -10, -10);

        var sprite = Image.createRect(8, 8, 0xFFFFFF);
        sprite.centerOrigin();
        sprite.angle = 45;

        graphic = sprite;
    }

    override public function update() {
        var playerCollide:Player = cast(collide('player', x, y));

        if (playerCollide != null) {
            playerCollide.addEnergy(0.5);
            world.remove(this);
        }
    }
}
