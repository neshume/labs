class OverlayShader extends h3d.shader.ScreenShader {

	static var SRC = {

		@param var texture : Sampler2D;
		@param var bgColor : Vec4;

		inline function blendOverlay(base:Vec3, blend:Vec3) : Vec3 {
			return mix(
				1.0 - 2.0 * (1.0 - base) * (1.0 - blend),
				2.0 * base * blend,
				base.rgb.dot( vec3(0.2126, 0.7152, 0.0722) ) // luminance
			);
		}

		inline function blendHardLight(base:Vec3, blend:Vec3) : Vec3 {
			return 1.0 - 2.0 * (1.0 - base) * (1.0 - blend);
		}

		function fragment() {
			var sourceColor = texture.get(input.uv);
			pixelColor.rgba = vec4(
				blendOverlay( sourceColor.rgb, bgColor.rgb ),
				sourceColor.a
			);
		}
	};

	public function new(c:UInt) {
		super();
		this.bgColor.setColor(c);
	}
}