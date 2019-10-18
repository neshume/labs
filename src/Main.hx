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

		#if js
		music = hxd.Res.music_mp3.play();
		#else
		music = hxd.Res.music_ogg.play();
		#end
	}

	override function update() {
		super.update();

		if( hxd.Key.isPressed(hxd.Key.SPACE) ) {
			music.pause = !music.pause;
			// music.volume = music.volume==0 ? 1 : 0;
			indicator.tile = h2d.Tile.fromColor( music.pause ? 0xff0000 : 0x00ff00 );
		}
	}

}
