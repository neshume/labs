import dn.Color as C;
import dn.M;

class Main extends hxd.App {
	public static var ME : Main;

	// Boot
	static function main() new Main();

	// Engine ready
	var f : h2d.filter.Filter;
	override function init() {
		ME = this;

		// Inits
		hxd.Key.initialize();
		hxd.Res.initEmbed();

		var root = new h2d.Object(s2d);
		root.scale(6);

		// Grid
		var size = 256;
		var grid = 16;
		var rseed = new dn.Rand(0);
		var g = new h2d.Graphics(root);
		for(cx in 0...M.ceil(size/grid))
		for(cy in 0...M.ceil(size/grid)) {
			g.beginFill(C.makeColorHsl(rseed.range(0,1), 0, rseed.range(0,0.3)), 1);
			g.drawRect(cx*grid, cy*grid, grid, grid);
		}

		// Knight
		var knight = hxd.Res.knight.toTile();
		var b = new h2d.Bitmap(knight, root);
		// b.filter = new dn.heaps.filter.PixelOutline();

		// Filter
		var gradientMap = hxd.Res.gold.toTexture();
		new dn.heaps.filter.GradientMap(gradientMap, 1, OnlyLights);
		s2d.filter = f = new dn.heaps.filter.GradientMap(gradientMap, 0.66, OnlyShadows);
		// s2d.filter = f = new TestFilter();
	}

	override function update(dt:Float) {
		super.update(dt);

		if( hxd.Key.isPressed(hxd.Key.SPACE) )
			s2d.filter = s2d.filter==null ? f : null;

		if( hxd.Key.isPressed(hxd.Key.ESCAPE) )
			hxd.System.exit();
	}
}

