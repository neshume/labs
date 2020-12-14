class CubeTest extends dn.Process {

	var cube : h3d.scene.Mesh;

	public function new() {
		super();

		var prim = new h3d.prim.Cube();
		prim.unindex();
		prim.addNormals();
		prim.addUVs();

		var cube =
	}

	override function update() {
		super.update();
	}
}