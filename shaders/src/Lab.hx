class Lab extends dn.Process {
	var lightMapTex : h3d.mat.Texture;

	var wid : Int;
	var hei : Int;
	var x = 70.;
	var y = 30.;

	public function new() {
		super(Main.ME);
		createRootInLayers(Main.ME.root,0);

		// Image
		var imgTile = hxd.Res.memento1.toTile();
		var bmp = new h2d.Bitmap(imgTile, root);
		wid = Std.int(imgTile.width);
		hei = Std.int(imgTile.height);
		Main.ME.fit(wid,hei);

		// Light map
		lightMapTex = new h3d.mat.Texture(wid,hei, [Target]);

		// Gradient map
		var gradientMap = hxd.Res.blue.toTexture();

		// Filter
		root.filter = new dn.heaps.filter.Debug();
	}

	inline function cos(f:Float, spd=1.0) {
		return Math.cos(ftime*0.02*spd) * f;
	}

	inline function sin(f:Float, spd=1.0) {
		return Math.sin(0.7+ftime*0.02*spd) * f;
	}

	function renderLightMap(x,y) {
		var g = new h2d.Graphics();
		g.beginFill(0x0); g.drawRect(0,0,wid,hei);
		var r = 20;
		g.beginFill(0xffffff); g.drawCircle(x+cos(1,0.5), y, r+cos(1));
		g.beginFill(0xffffff,0.3); g.drawCircle(x, y, r*1.3+cos(1));
		g.beginFill(0xffffff,0.15); g.drawCircle(x,y,r*1.5+sin(2));
		g.beginFill(0xffffff,0.07); g.drawCircle(x,y,r*1.6);
		g.drawTo(lightMapTex);
	}


	var old : h2d.filter.Filter = null;
	override function update() {
		super.update();

		// Toggle filter
		if( hxd.Key.isPressed(hxd.Key.SPACE) ) {
			if( root.filter!=null ) {
				old = root.filter;
				root.filter = null;
			}
			else
				root.filter = old;
		}

		// Control light
		var spd = 0.4*tmod;
		if( K.isDown(K.LEFT) ) x-=spd;
		if( K.isDown(K.RIGHT) ) x+=spd;
		if( K.isDown(K.UP) ) y-=spd;
		if( K.isDown(K.DOWN) ) y+=spd;

		// Refresh
		renderLightMap(x,y);
	}
}