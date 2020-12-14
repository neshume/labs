class Outline extends dn.Process {
	public function new() {
		super();

		createRoot(Main.ME.s2d);
		root.scale(12);

		// Image
		var imgTile = hxd.Res.knight.toTile();
		var bmp = new h2d.Bitmap(imgTile, root);
		bmp.setPosition(3,3);
		bmp.filter = new dn.heaps.filter.PixelOutline(0xffcc00);
	}
}