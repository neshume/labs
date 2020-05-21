import dn.Color as C;

class Main extends hxd.App {
	public static var ME : Main;

	// Boot
	static function main() new Main();

	// Engine ready
	static var gradient : h2d.Graphics;
	override function init() {
		ME = this;

		var root = new h2d.Object(s2d);
		root.scale(4);

		var size = 256;
		var sat = 0.7;
		var light = 0.5;

		// Base BG
		var bg = new h2d.Graphics(root);
		var n = 16;
		for(i in 0...n) {
			bg.beginFill( C.makeColorHsl( i/(n-1), sat, light ) );
			bg.drawRect(0, i*size/n, size, size/n);
		}
		var bgTex = new h3d.mat.Texture(size,size, [Target]);
		bg.drawTo(bgTex);

		// Grayscale gradient
		gradient = new h2d.Graphics(root);
		for(i in 0...size) {
			gradient.beginFill(C.makeColorHsl(0,0,i/size), 1);
			gradient.drawRect(i, 0, 1, size);
		}
		gradient.filter = new OverlayFilter(bgTex);
	}

	override function update(deltaTime:Float) {
		super.update(deltaTime);
		if( hxd.Key.isPressed(hxd.Key.SPACE) )
			gradient.visible = !gradient.visible;
	}
}

