class Main extends hxd.App {
	public static var ME : Main;

	// Boot
	static function main() new Main();

	// Engine ready
	override function init() {
		ME = this;

		haxe.Timer.delay( function() {
			hxd.File.browse( function(browser) {
				trace("open: "+browser.fileName);
			});
		}, 1000);
	}

	override function update(deltaTime:Float) {
		super.update(deltaTime);
	}
}

