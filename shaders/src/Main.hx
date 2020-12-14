import dn.Color as C;
import dn.M;

class Main extends hxd.App {
	public static var ME : Main;

	// Boot
	static function main() new Main();

	// Engine ready
	static var root : h2d.Object;
	override function init() {
		ME = this;

		// Inits
		hxd.Key.initialize();
		hxd.Res.initEmbed();

		// new DarknessGradient();
		// new Outline();
		new Lab();
	}

	override function update(dt:Float) {
		super.update(dt);

		dn.Process.updateAll(hxd.Timer.tmod);

		if( hxd.Key.isPressed(hxd.Key.ESCAPE) )
			hxd.System.exit();
	}
}

