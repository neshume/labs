class DarknessGradient extends dn.Process {
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
		Main.ME.fit(200,200);
		wid = Std.int(bgTile.width);
		hei = Std.int(bgTile.height);

		// Light map texture
		lightMapTex = new h3d.mat.Texture(2,2, [Target]);
		initLightMapTex();

		// Load gradient map
		var gradientMap = hxd.Res.blue.toTexture();

		// Filter
		darkness = new dn.heaps.filter.GradientDarkness(lightMapTex, gradientMap);
		darkness.darknessColorMul = 0.6;

		darkness.xDistortPx = 0.5;
		darkness.xDistortWaveLenPx = 30;

		darkness.yDistortPx = 0.7;
		darkness.yDistortWaveLenPx = 35;
		darkness.yDistortSpeed = 0.7;

		root.filter = darkness;
		// root.filter = new dn.heaps.filter.Debug();

		renderLightMap(x,y);
	}

	inline function initLightMapTex() {
		lightMapTex.resize( M.ceil(Boot.ME.s2d.width), M.ceil(Boot.ME.s2d.height) );
		trace(lightMapTex.width+"x"+lightMapTex.height);
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
		base.scaleX = viewWid;
		base.scaleY = viewHei;

		// Player light
		var t = hxd.Res.halo.toTile();
		t.setCenterRatio();
		var bmp = new h2d.Bitmap(t, lightMap);
		bmp.x = x + bg.x;
		bmp.y = y + bg.y;
		bmp.blendMode = Add;

		// Fixed lights
		// var rseed = new dn.Rand(0);
		// var pts = [
		// 	{ x:176, y:186 },
		// 	{ x:436, y:62 },
		// 	{ x:46, y:192 },
		// 	{ x:178, y:50 },
		// 	{ x:240, y:50 },
		// ];
		// for(pt in pts) {
		// 	var bmp = new h2d.Bitmap(t, lightMap);
		// 	bmp.x = pt.x + bg.x;
		// 	bmp.y = pt.y + bg.y;
		// 	bmp.alpha = rseed.range(0.4,0.7);
		// 	bmp.blendMode = Add;
		// }

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