class Darkness extends dn.Process {
	var bg : h2d.Bitmap;
	var darkness : dn.heaps.filter.GradientDarkness;
	var lightMap : h2d.Object;
	var lightMapTex : h3d.mat.Texture;
	var wid : Int;
	var hei : Int;
	var x = 70.;
	var y = 70.;

	var viewWid(get,never) : Int; inline function get_viewWid() return Boot.ME.s2d.width;
	var viewHei(get,never) : Int; inline function get_viewHei() return Boot.ME.s2d.height;

	public function new() {
		super(Main.ME);

		createRootInLayers(Main.ME.root,0);

		// Image
		var bgTile = hxd.Res.cats.toTile();
		bg = new h2d.Bitmap(bgTile, root);
		wid = Std.int(bgTile.width);
		hei = Std.int(bgTile.height);
		Main.ME.fit(250,250);

		// Light map texture
		lightMapTex = new h3d.mat.Texture(2,2, [Target]);
		initLightMapTex();

		// Load gradient map
		var gradientMap = hxd.Res.blue.toTexture();

		// Filter
		darkness = new dn.heaps.filter.GradientDarkness(lightMapTex, gradientMap);
		root.filter = darkness;
		darkness.darknessEdgeEnhance = 0.4;
		darkness.darknessColorMul = 0.7;

		darkness.xDistortPx = 0.8;
		darkness.xDistortWaveLenPx = 32;
		darkness.xDistortSpeed = 0.5;

		darkness.yDistortPx = 0.8;
		darkness.yDistortWaveLenPx = 32;
		darkness.yDistortSpeed = 0.5;

		renderLightMap(x,y);
	}

	inline function initLightMapTex() {
		lightMapTex.resize( viewWid, viewHei);
	}

	override function onResize() {
		super.onResize();
		initLightMapTex();
		trace("resize");
	}

	function renderLightMap(x:Float, y:Float) {
		if( lightMap==null )
			lightMap = new h2d.Object();
		else
			lightMap.removeChildren();

		// Black base
		var base = new h2d.Bitmap( h2d.Tile.fromColor(0x0), lightMap );
		base.scaleX = wid;
		base.scaleY = hei;

		// Player light
		var t = hxd.Res.haloRamp.toTile();
		t.setCenterRatio();
		var bmp = new h2d.Bitmap(t, lightMap);
		bmp.x = x + bg.x;
		bmp.y = y + bg.y;
		bmp.scale(1.2);
		bmp.blendMode = Add;

		// Fixed lights
		var t = hxd.Res.halo.toTile();
		t.setCenterRatio();
		var rseed = new dn.Rand(0);
		var pts = [
			{ x:165, y:196 }, // TV
		// 	{ x:436, y:62 },
			// { x:46, y:192 },
		// 	{ x:178, y:50 }, // entrance left
		// 	{ x:240, y:50 }, // entrance right
		];
		for(pt in pts) {
			var bmp = new h2d.Bitmap(t, lightMap);
			bmp.scale(0.66);
			bmp.x = pt.x + bg.x;
			bmp.y = pt.y + bg.y;
			bmp.scale(1.2);
			bmp.alpha = rnd(0.8,1)*0.7;
			bmp.blendMode = Add;
		}

		lightMap.drawTo(lightMapTex);
	}

	override function update() {
		super.update();

		// Control pos
		var spd = 1*tmod;
		if( K.isDown(K.LEFT) ) x-=spd;
		if( K.isDown(K.RIGHT) ) x+=spd;
		if( K.isDown(K.UP) ) y-=spd;
		if( K.isDown(K.DOWN) ) y+=spd;

		x = M.fclamp(x, 16, wid-16);
		y = M.fclamp(y, 22, hei-16);

		bg.x = -x + viewWid*0.5;
		bg.y = -y + viewHei*0.5;
		bg.x = M.fclamp(bg.x, -(bg.tile.width-viewWid), 0);
		bg.y = M.fclamp(bg.y, -(bg.tile.height-viewHei), 0);

		darkness.xDistortCameraPx = -bg.x;
		darkness.yDistortCameraPx = -bg.y;

		// Refresh
		renderLightMap(x,y);
	}

}