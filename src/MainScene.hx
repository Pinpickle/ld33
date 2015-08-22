import com.haxepunk.Scene;
import leveled.LeveledParser;
import openfl.Assets;

class MainScene extends Scene
{
	public override function begin()
	{
		var parser = new LeveledParser();
		parser.setGlobalString(Assets.getText('levels/global.yml'));

		var level = parser.parseLevelString(Assets.getText('levels/level_1.yml'));

		var walls:Iterable<Dynamic> = level.get('layers').get('walls').get('contents');
		var objects:Iterable<Dynamic> = level.get('layers').get('objects').get('contents');

		for (wall in walls) {
			add(new Wall(wall.get('x'), wall.get('y')));
		}

		for (object in objects) {
			switch (object.get('type')) {
			case 'player':
				add(new Player(cast(object.get('x')), cast(object.get('y'))));
			}
		}

	}
}
