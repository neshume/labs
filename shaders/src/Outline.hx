class Outline extends dn.Process {
	public function new() {
		super(Main.ME);

		createRootInLayers(Main.ME.root,0);

		// Image
		var imgTile = hxd.Res.knight.toTile();
		Main.ME.fit(imgTile.width+20,imgTile.height+20);
		var bmp = new h2d.Bitmap(imgTile, root);
		bmp.setPosition(3,14);
		bmp.filter = new dn.heaps.filter.PixelOutline(0xffcc00);
	}
}