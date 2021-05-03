import hxd.Key as K;

class Main extends hxd.App {
	public static var ME : Main;
	var tf : h2d.Text;

	// Boot
	static function main() new Main();

	// Engine ready
	var meta = false;
	override function init() {
		ME = this;
		tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
		tf.textColor = 0xffcc00;
		s2d.scaleMode = AutoZoom(200,200, true);
		js.Browser.document.addEventListener("keydown", (ev:js.html.KeyboardEvent)->{
			meta = ev.metaKey;
			ev.preventDefault();
			ev.stopPropagation();
		});
		js.Browser.document.addEventListener("keyup", (ev:js.html.KeyboardEvent)->{
			meta = false;
		});
		js.Browser.document.addEventListener("blur", (ev:js.html.KeyboardEvent)->{
			meta = false;
			tf.alpha = 0.4;
		});
		js.Browser.document.addEventListener("focus", (ev:js.html.KeyboardEvent)->{
			meta = false;
			tf.alpha = 1;
		});
	}

	function isCtrlDown() {
		return K.isDown(K.LEFT_WINDOW_KEY)
			|| K.isDown(K.RIGHT_WINDOW_KEY)
			|| K.isDown(91)
			|| K.isDown(92)
			|| K.isDown(93)
			|| meta
			|| K.isDown(K.CTRL);
	}

	override function update(deltaTime:Float) {
		super.update(deltaTime);
		tf.text = "";
		tf.text += "Z="+K.isDown(K.Z)+"\n";
		tf.text += "K91="+K.isDown(91)+"\n";
		tf.text += "K92="+K.isDown(92)+"\n";
		tf.text += "K93="+K.isDown(93)+"\n";
		tf.text += "metaJS="+meta+"\n";
		tf.text += "CMD-Z="+( K.isDown(K.Z) && isCtrlDown() )+"\n";
		tf.textColor = ( K.isDown(K.Z) && isCtrlDown() ) ? 0x00ff00 : 0x00ccff;
	}
}

