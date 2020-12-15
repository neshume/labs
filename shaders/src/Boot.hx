/**
	Docs:
		https://gist.github.com/Yanrishatum/6eb2f6de05fc951599d5afccfab8d0a9
		https://heaps.io/documentation/hxsl.html
**/

class Boot extends hxd.App {
	public static var ME : Boot;
	// Boot
	static function main() new Boot();

	// Engine ready
	static var root : h2d.Object;
	override function init() {
		ME = this;
		hxd.Key.initialize();
		hxd.Res.initEmbed();
		new Main();
	}

	override function onResize() {
		super.onResize();
		Process.resizeAll();
	}

	override function update(dt:Float) {
		super.update(dt);

		dn.Process.updateAll(hxd.Timer.tmod);

		if( hxd.Key.isPressed(hxd.Key.ESCAPE) )
			hxd.System.exit();
	}
}

