package scenes;

import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.tweens.misc.VarTween;
import com.haxepunk.utils.Draw;
import leveled.LeveledParser;
import openfl.Assets;

import entities.Wall;
import entities.Player;
import entities.EnergyBall;
import entities.HUD;
import entities.Door;
import entities.IActionable;
import entities.Background;

class MainScene extends Scene
{
	public var actionEntities:List<IActionable> = new List<IActionable>();
	public var player:Player = null;
	public var hud:HUD = null;

	private var parser = new LeveledParser();

	public var width:Int = 0;
	public var height:Int = 0;

	private var openTween:VarTween = new VarTween();
	public var openOpacity:Float = 0;

	public function new()
	{
		super();
		parser.setGlobalString(Assets.getText('levels/global.yml'));
		addTween(openTween);
	}

	public function loadLevel(name:String, initial:Bool = false):Array<Entity>
	{
		HXP.clear(_add);
		removeAll();

		openOpacity = 1;
		openTween.tween(this, 'openOpacity', 0, 0.5);
		var level = parser.parseLevelString(Assets.getText('levels/' + name + '.yml'));

		var walls:Iterable<Dynamic> = level.get('layers').get('walls').get('contents');
		var objects:Iterable<Dynamic> = level.get('layers').get('objects').get('contents');

		width = level.get('width');
		height = level.get('height');

		trace(width, height);

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
				if (initial) {
					player = new Player(x, y);
				}
			case 'energy':
				add(new EnergyBall(x, y));
			case 'door':
				add(new Door(x, y, object.get('doorid'), object.get('tolevel'), object.get('todoor')));
			}
		}

		if (player != null) {
			add(player);
			add(new Background());
			add(new HUD(player));
		}

		return _add;
	}

	override public function render() {
		super.render();
		Draw.rectPlus(HXP.camera.x, HXP.camera.y, HXP.width, HXP.height, 0x000000, openOpacity);
	}

	public override function begin()
	{
		loadLevel('level_1', true);
	}

	override public function updateLists(shouldAdd:Bool = true)
	{
		if (_remove.length > 0)
		{
			for (e in _remove)
			{
				if (Std.is(e, IActionable)) {
					actionEntities.remove(cast (e));
				}
			}
		}

		// add entities
		if (shouldAdd && _add.length > 0)
		{
			for (e in _add)
			{
				if (Std.is(e, IActionable)) {
					actionEntities.add(cast (e));
				}
			}
		}

		super.updateLists(shouldAdd);
	}
}
