package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Draw;

import scenes.MainScene;

class Player extends PhysicsEntity {
    public var acc = 3000;
    public var energy:Float = 0;
    public var maxEnergy:Float = 10;

    private var actionSprite:Text = new Text('Z');

    public function new(x:Float, y:Float) {
        super(x, y);
        stopAtSolid = true;
        setHitbox(24, 24, 12, 12);
        graphic = Image.createCircle(12, 0xFFFFFF);

        actionSprite.centerOrigin();

        type = 'player';
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

        var action:IActionable;
        if ((Input.released('action')) && ((action = getAction()) != null)) {
            action.executeAction(this);
        }

        if (Input.pressed('up')) {
            ySpeed = -500;
        }

        super.update();

        HXP.setCamera(x - HXP.width / 2, y - HXP.height / 2);
    }

    override public function render() {
        super.render();

        if (canAction()) {
            Draw.graphic(actionSprite, cast(x), cast(y - 36), layer);
        }
    }

    public function addEnergy(amount:Float) {
        energy += amount;
        if (energy > maxEnergy) {
            energy = maxEnergy;
        }
    }

    private function getAction():IActionable {
        if (Std.is(scene, MainScene)) {
            var main:MainScene = cast(scene);

            for (e in main.actionEntities) {
                if (e.canAction(this)) {
                    return e;
                }
            }
        }

        return null;
    }

    private function canAction():Bool {
        return getAction() != null;
    }
}
