class DarknessGradient extends dn.Process {
	var lightMap : h2d.Graphics;
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
		var img = new h2d.Bitmap(imgTile, root);
		Main.ME.fit(imgTile.width, imgTile.height);
		wid = Std.int(imgTile.width);
		hei = Std.int(imgTile.height);

		// Light map texture
		lightMapTex = new h3d.mat.Texture(wid,hei, [Target]);

		// Load gradient map
		var gradientMap = hxd.Res.blue.toTexture();

		// Filter
		var f = new dn.heaps.filter.GradientDarkness(lightMapTex, gradientMap);
		f.xDistortOffsetPx = 0.5;
		f.xDistortWaveLenPx = 10;

		f.yDistortOffsetPx = 0.7;
		f.yDistortWaveLenPx = 15;
		f.yDistortSpeed = 0.7;

		root.filter = f;

		lightMap = new h2d.Graphics();
		renderLightMap(x,y);
	}

	function renderLightMap(x:Float, y:Float) {
		lightMap.clear();
		lightMap.beginFill(0x0);
		lightMap.drawRect(0,0,wid,hei);

		var t = hxd.Res.halo.toTile();
		var s = 0.6;
		lightMap.beginTileFill(x-t.width*s*0.5, y-t.height*s*0.5, s,s, t);
		lightMap.drawRect(x-t.width*s*0.5, y-t.height*s*0.5, t.width*s, t.height*s);
		lightMap.endFill();

		lightMap.drawTo(lightMapTex);
	}

	override function update() {
		super.update();

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