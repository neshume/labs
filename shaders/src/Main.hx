import dn.Color as C;
import dn.M;

class Main extends hxd.App {
	public static var ME : Main;

	// Boot
	static function main() new Main();

	// Engine ready
	static var root : h2d.Object;
	var f : h2d.filter.Filter;
	override function init() {
		ME = this;

		// Inits
		hxd.Key.initialize();
		hxd.Res.initEmbed();

		root = new h2d.Object(s2d);
		root.scale(7);

		// Image
		var imgTile = hxd.Res.memento2.toTile();
		var img = new h2d.Bitmap(imgTile, root);

		// Light map
		var w = Std.int(imgTile.width);
		var h = Std.int(imgTile.height);
		var g = new h2d.Graphics();
		g.beginFill(0x0); g.drawRect(0,0,w,h);
		var x = 58;
		var y = 32;
		var r = 20;
		g.beginFill(0xffffff); g.drawCircle(x,y,r);
		g.beginFill(0xffffff,0.3); g.drawCircle(x,y,r*1.15);
		g.beginFill(0xffffff,0.15); g.drawCircle(x,y,r*1.5);

		var lightMapTex = new h3d.mat.Texture(w,h, [Target]);
		g.drawTo(lightMapTex);

		// Filter
		var gradientMap = hxd.Res.blue.toTexture();
		root.filter = f = new dn.heaps.filter.GradientDarkness(lightMapTex, gradientMap, 1);
		// root.filter = f = new TestFilter(lightMapTex, gradientMap);
	}

	override function update(dt:Float) {
		super.update(dt);

		if( hxd.Key.isPressed(hxd.Key.SPACE) )
			root.filter = s2d.filter==null ? f : null;

		if( hxd.Key.isPressed(hxd.Key.ESCAPE) )
			hxd.System.exit();
	}
}

