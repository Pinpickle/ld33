package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Draw;

class HUD extends Entity {
    public var player:Player;

    public function new(player:Player) {
        super();

        this.player = player;
    }

    override public function render() {
        Draw.rectPlus(10 + HXP.camera.x, HXP.height - 20 + HXP.camera.y, cast ((HXP.width - 20) * player.energy / player.maxEnergy), 10, 0xFFFFFF);
    }

}
