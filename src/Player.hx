import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Player extends PhysicsEntity {
    public var acc = 3000;

    public function new(x:Float, y:Float) {
        super(x, y);
        stopAtSolid = true;
        setHitbox(24, 24, 12, 12);
        graphic = Image.createCircle(12, 0xFFFFFF);
        cast (graphic, Image).centerOrigin();
    }

    override public function update() {
        ySpeed += 1000 * HXP.elapsed;

        if (Input.check('left')) {
            xSpeed -= acc * HXP.elapsed;
        }

        if (Input.check('right')) {
            xSpeed += acc * HXP.elapsed;
        }

        if ((!Input.check('left')) && (!Input.check('right'))) {
            xSpeed *= 0.7;
        } else {
            xSpeed *= 0.95;
        }

        if (Input.pressed('up')) {
            ySpeed = -500;
        }

        super.update();
    }
}
