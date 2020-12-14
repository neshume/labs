class TestFilter extends h2d.filter.Shader<InternalShader> {

	public function new() {
		var s = new InternalShader();
		super(s);
	}

}


// --- Shader -------------------------------------------------------------------------------
private class InternalShader extends h3d.shader.ScreenShader {
	static var SRC = {
		@param var texture : Sampler2D;

		inline function getLum(col:Vec3) : Float {
			return col.rgb.dot( vec3(0.2126, 0.7152, 0.0722) );
		}

		function fragment() {
			var pixel : Vec4 = texture.get(calculatedUV);
			pixelColor = pixel;

		}
	};
}
