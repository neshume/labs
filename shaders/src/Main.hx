/**
	Docs:
		https://gist.github.com/Yanrishatum/6eb2f6de05fc951599d5afccfab8d0a9
		https://heaps.io/documentation/hxsl.html
**/

class Main extends dn.Process {
	public static var ME : Main;

	public function new() {
		super();
		createRoot(Boot.ME.s2d);
		ME = this;
		fit(160,100);

		// Bind 1-9 keys to lab classes
		Boot.ME.s2d.addEventListener((ev)->{
			switch ev.kind {
				case EKeyDown:
					if( ev.keyCode>=K.NUMBER_1 && ev.keyCode<=K.NUMBER_9 )
						runLab( ev.keyCode-K.NUMBER_1 );
				case _:
			}
		});
		runLab(0);
	}

	function runLab(idx:Int) {
		killAllChildrenProcesses();
		switch idx {
			case 0: new Lab();
			case 1: new DarknessGradient();
			case 2: new Outline();
		}
	}

	public inline function fit(w:Float,h:Float) {
		Boot.ME.s2d.scaleMode = LetterBox(M.ceil(w),M.ceil(h), true, Center, Center);
		// Boot.ME.s2d.scaleMode = Zoom(2);
	}
}

