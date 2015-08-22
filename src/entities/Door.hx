package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

import scenes.MainScene;

class Door extends Entity implements IActionable
{
    public var doorId:Dynamic;
    private var goLevel:String;
    private var goDoor:String;

    public function new(x:Float, y:Float, doorid:Dynamic, level:String, todoor:Dynamic) {
        super(x, y);
        var sprite = Image.createRect(48, 64, 0x000000);
        sprite.originX = 24;
        sprite.originY = 64;
        graphic = sprite;

        doorId = doorid;
        goLevel = level;
        goDoor = todoor;

        setHitbox(48, 64, 24, 64);
    }

    public function canAction(player:Player) {
        return (collide('player', x, y) != null);
    }

    public function executeAction(player:Player) {
        var main:MainScene = cast (scene);
        var entities = main.loadLevel(goLevel);

        for (e in entities) {
            if (Std.is(e, Door)) {
                var door:Door = cast (e);

                if (door.doorId == goDoor) {
                    trace('si');
                    player.x = door.x;
                    player.y = door.y - player.originY - 1;
                    player.xSpeed = 0;
                    player.ySpeed = 0;
                    return;
                }
            }
        }
    }
}
