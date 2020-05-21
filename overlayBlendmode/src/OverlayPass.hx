class OverlayPass extends h3d.pass.ScreenFx<OverlayShader> {

	public function new(bgTexture:h3d.mat.Texture) {
		super( new OverlayShader(bgTexture) );
	}

	public function apply( src : h3d.mat.Texture, out : h3d.mat.Texture, ?mask : h3d.mat.Texture) {
		engine.pushTarget(out);
		shader.texture = src;
		render();
		engine.popTarget();
	}

}