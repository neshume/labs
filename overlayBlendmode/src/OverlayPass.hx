class OverlayPass extends h3d.pass.ScreenFx<OverlayShader> {

	public function new(c:UInt) {
		super( new OverlayShader(c) );
	}

	public function apply( src : h3d.mat.Texture, out : h3d.mat.Texture, ?mask : h3d.mat.Texture) {
		engine.pushTarget(out);
		shader.texture = src;
		render();
		engine.popTarget();
	}

}