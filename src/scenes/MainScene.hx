package scenes;

import com.haxepunk.Scene;
import com.haxepunk.Entity;
import leveled.LeveledParser;
import openfl.Assets;

import entities.Wall;
import entities.Player;
import entities.EnergyBall;
import entities.HUD;
import entities.Door;
import entities.IActionable;

class MainScene extends Scene
{
	public var actionEntities:List<IActionable> = new List<IActionable>();

	public override function begin()
	{
		var parser = new LeveledParser();
		parser.setGlobalString(Assets.getText('levels/global.yml'));

		var level = parser.parseLevelString(Assets.getText('levels/level_1.yml'));

		var walls:Iterable<Dynamic> = level.get('layers').get('walls').get('contents');
		var objects:Iterable<Dynamic> = level.get('layers').get('objects').get('contents');
		var player:Player = null;

		for (wall in walls) {
			add(new Wall(wall.get('x'), wall.get('y'), cast(wall.get('width')), cast(wall.get('height'))));
		}

		for (object in objects) {
			var x:Float = cast(object.get('x'));
			var y:Float = cast(object.get('y'));
			var width:Float = cast(object.get('width'));
			var height:Float = cast(object.get('height'));

			switch (object.get('type')) {
			case 'player':
				player = new Player(x, y);
				add(player);
			case 'energy':
				add(new EnergyBall(x, y));
			case 'door':
				add(new Door(x, y));
			}
		}

		if (player != null) {
			add(new HUD(player));
		}

		trace(Assets.list(openfl.AssetType.TEXT));

	}

	override public function add<E:Entity>(e:E):E
	{
		super.add(e);

		if (Std.is(e, IActionable)) {
			actionEntities.add(cast (e));
		}

		return e;
	}

	override public function remove<E:Entity>(e:E):E
	{
		super.remove(e);

		if (Std.is(e, IActionable)) {
			actionEntities.remove(cast (e));
		}

		return e;
	}
}
