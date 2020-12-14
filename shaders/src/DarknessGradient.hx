class DarknessGradient extends dn.Process {
	public function new() {
		super();

		createRoot(Main.ME.s2d);
		root.scale(12);

		// Image
		var imgTile = hxd.Res.memento1.toTile();
		var img = new h2d.Bitmap(imgTile, root);

		// Light map
		var w = Std.int(imgTile.width);
		var h = Std.int(imgTile.height);
		var g = new h2d.Graphics();
		g.beginFill(0x0); g.drawRect(0,0,w,h);
		var x = 70;
		var y = 20;
		var r = 20;
		g.beginFill(0xffffff); g.drawCircle(x,y,r);
		g.beginFill(0xffffff,0.3); g.drawCircle(x,y,r*1.15);
		g.beginFill(0xffffff,0.15); g.drawCircle(x,y,r*1.5);

		var lightMapTex = new h3d.mat.Texture(w,h, [Target]);
		g.drawTo(lightMapTex);

		// Filter
		var gradientMap = hxd.Res.blue.toTexture();
		root.filter = new dn.heaps.filter.GradientDarkness(lightMapTex, gradientMap, 1);
	}
}