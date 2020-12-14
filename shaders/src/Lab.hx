class Lab extends dn.Process {
	public function new() {
		super();

		createRoot(Main.ME.s2d);
		root.scale(12);

		// Image
		var imgTile = hxd.Res.memento1.toTile();
		var bmp = new h2d.Bitmap(imgTile, root);
		root.filter = new dn.heaps.filter.GradientMap(hxd.Res.gold.toTexture(), OnlyShadows, 0.7);
	}


	var old : h2d.filter.Filter = null;
	override function update() {
		super.update();
		if( hxd.Key.isPressed(hxd.Key.SPACE) ) {
			if( root.filter!=null ) {
				old = root.filter;
				root.filter = null;
			}
			else
				root.filter = old;
		}
	}
}