class Main extends hxd.App {
	public static var ME : Main;

	// Boot
	static function main() new Main();

	var seed = 2;

	// Engine ready
	override function init() {
		ME = this;
		var distrib = new Map();
		for(i in 0...10000) {
			var r = dn.M.randSeedCoords(seed, i, 5, 3);
			if( !distrib.exists(r) )
				distrib.set(r,1);
			else
				distrib.set(r, distrib.get(r)+1);
		}
		trace(distrib);
	}

	override function update(deltaTime:Float) {
		super.update(deltaTime);
	}
}

