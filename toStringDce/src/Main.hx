class Main extends hxd.App {
	public static var ME : Main;

	// Boot
	static function main() new Main();

	// Engine ready
	override function init() {
		ME = this;

		var t = new Test();
		trace(t.toString());
		// myDebug(t);
	}

	function myDebug(v:Dynamic) {
		trace(Std.string(v));
	}

	override function update(deltaTime:Float) {
		super.update(deltaTime);
	}
}

