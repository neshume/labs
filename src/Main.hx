import hxd.Key;
import hxd.Pad;

class Main extends dn.Process {
	public static var ME : Main;
	var ctrl : dn.heaps.Controller;
	var ca : dn.heaps.Controller.ControllerAccess;

	var pad : hxd.Pad;

	public function new(scene:h2d.Scene) {
		super();
		ME = this;
		createRoot(scene);

		ctrl = new dn.heaps.Controller(scene);
		ca = ctrl.createAccess("main");

		pad = hxd.Pad.createDummy();
		trace(pad.name);
		hxd.Pad.wait(function(p) {
			pad = p;
			trace(pad.name);
		});
	}

	override function update() {
		super.update();

		if( pad.isDown(hxd.Pad.DEFAULT_CONFIG.A) )
			trace("hxd.Pad: A");

		if( ca.aDown() )
			trace("ControllerAccess: A");
	}
}