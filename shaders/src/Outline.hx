class Outline extends dn.Process {
	public function new() {
		super(Main.ME);

		createRoot(Main.ME.root);
		Main.ME.fit(50,50);

		// Image
		var imgTile = hxd.Res.knight.toTile();
		var bmp = new h2d.Bitmap(imgTile, root);
		bmp.setPosition(3,3);
		bmp.filter = new dn.heaps.filter.PixelOutline(0xffcc00);
	}
}