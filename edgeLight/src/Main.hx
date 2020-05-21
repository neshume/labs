import dn.*;
import hxd.Key;

class Main extends hxd.App {
	public static var ME : Main;

	var filter : EdgeLight;
	var sun : h2d.Graphics;
	var hero : h2d.Bitmap;

	// Boot
	static function main() new Main();

	// Engine ready
	override function init() {
		ME = this;
		hxd.Res.initEmbed();

		var root = new h2d.Object(s2d);
		root.scale(17);

		var col = 0xffcc00;

		var bg = new h2d.Graphics(root);
		bg.beginFill(0x424c6b);
		bg.drawRect(0,0,256,256);

		sun = new h2d.Graphics(root);
		sun.beginFill(col);
		sun.drawCircle(0,0,3);

		var t = hxd.Res.heroIdle0.toTile();
		hero = new h2d.Bitmap(t, root);
		hero.setPosition(8,8);

		filter = new EdgeLight( Color.addAlphaF(col, 1), -M.PI );
		hero.filter = filter;
	}

	override function update(deltaTime:Float) {
		super.update(deltaTime);

		if( Key.isDown(Key.LEFT) )
			filter.ang-=0.06;

		if( Key.isDown(Key.RIGHT) )
			filter.ang+=0.06;

		sun.x = hero.x + hero.tile.width*0.5 + Math.cos(filter.ang)*20;
		sun.y = hero.y + hero.tile.height*0.5 + Math.sin(filter.ang)*20;
	}
}


