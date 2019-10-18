class Boot extends hxd.App {
	public static var ME : Boot;

	// Boot
	static function main() {
		new Boot();
	}

	// Engine ready
	override function init() {
		ME = this;
		hxd.Res.initEmbed();
		hxd.Key.initialize();
		var console = new h2d.Console(hxd.Res.font.toFont(), s2d);
		h2d.Console.HIDE_LOG_TIMEOUT = 9999;
		dn.Lib.redirectTracesToH2dConsole(console);
		new Main(s2d);
		onResize();
	}

	override function onResize() {
		super.onResize();
		dn.Process.resizeAll();
	}

	override function update(deltaTime:Float) {
		dn.heaps.Controller.beforeUpdate();

		super.update(deltaTime);

		dn.Process.updateAll(hxd.Timer.tmod);
	}
}

