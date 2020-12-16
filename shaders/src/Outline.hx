class Outline extends dn.Process {
	public function new() {
		super(Main.ME);

		createRootInLayers(Main.ME.root,0);
		Main.ME.fit(50,50);

		// Image
		var imgTile = hxd.Res.knight.toTile();
		var bmp = new h2d.Bitmap(imgTile, root);
		bmp.setPosition(3,14);
		bmp.filter = new dn.heaps.filter.PixelOutline(0xffcc00);
	}
}