class Main extends dn.Process {
	public static var ME : Main;

	public function new(scene:h2d.Scene) {
		super();
		ME = this;
		createRoot(scene);
	}
}