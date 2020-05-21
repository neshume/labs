class Main extends hxd.App {
	public static var ME : Main;

	// Boot
	static function main() new Main();

	// Engine ready
	override function init() {
		ME = this;

		var root = new h2d.Object(s2d);
		root.scale(3);

		// var tg = new h2d.TileGroup(h2d.Tile.fromColor(0x0,128,128));
		// tg.drawToTextures();

		var size = 256;
		var col = dn.Color.hexToInt("#7B1C70");

		var bg = new h2d.Graphics(root);
		bg.beginFill(col);
		bg.drawRect(0,0,size,size);

		var g = new h2d.Graphics(root);
		g.filter = new OverlayFilter(col);
		for(i in 0...size) {
			g.beginFill(dn.Color.makeColorHsl(0,0,i/size), 1);
			g.drawRect(i, 0, 1, size);
		}
	}

	override function update(deltaTime:Float) {
		super.update(deltaTime);
	}
}

