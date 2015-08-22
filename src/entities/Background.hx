package entities;

import com.haxepunk.Entity;
import com.haxepunk.utils.Draw;

import scenes.MainScene;

class Background extends Entity {
    public function new() {
        super();
        layer = 50;
    }

    override public function render() {
        var main:MainScene = cast (scene);
        Draw.rectPlus(0, 0, main.width, main.height, 0xAAAAAA);
    }
}
