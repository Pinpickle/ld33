import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Main extends Engine
{

	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("up", [Key.UP, Key.W, Key.SPACE]);
		Input.define("down", [Key.DOWN, Key.S]);

		HXP.scene = new MainScene();
	}

	public static function main() { new Main(); }

}
