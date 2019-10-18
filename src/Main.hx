class Main extends dn.Process {
	public static var ME : Main;

	var music : hxd.snd.Channel;
	var indicator : h2d.Bitmap;

	public function new(scene:h2d.Scene) {
		super();
		ME = this;
		createRoot(scene);

		indicator = new h2d.Bitmap(h2d.Tile.fromColor(0x00ff00), root);
		indicator.setPosition(50,50);
		indicator.scale(100);

		music = hxd.Res.music.play();
		music.volume = 0.4;
	}

	override function update() {
		super.update();

		if( hxd.Key.isPressed(hxd.Key.SPACE) ) {
			music.pause = !music.pause;
			indicator.tile = h2d.Tile.fromColor( music.pause ? 0xff0000 : 0x00ff00 );
		}
	}

}
