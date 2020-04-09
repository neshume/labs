class Main extends hxd.App {
	public static var ME : Main;

	// Boot
	static function main() new Main();

	// Engine ready
	override function init() {
		ME = this;
	}

	override function update(deltaTime:Float) {
		super.update(deltaTime);
	}
}

