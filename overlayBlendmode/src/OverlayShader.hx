class OverlayShader extends h3d.shader.ScreenShader {

	static var SRC = {

		@param var texture : Sampler2D;
		@param var bg : Sampler2D;


		function getSaturation(col:Vec3) : Float {
			var maxCol = max( max(col.r,col.g), col.b );
			if( maxCol==0 )
				return 0.;
			else {
				return ( maxCol - min( min(col.r,col.g), col.b ) ) / maxCol;
			}
		}

		inline function getLuminance(col:Vec3) : Float {
			return col.rgb.dot( vec3(0.2126, 0.7152, 0.0722) );
		}

		inline function mixOverlay(source:Vec3, bg:Vec3) : Vec3 {
			return mix(
				1.0 - 2.0 * (1.0 - source) * (1.0 - bg),
				2.0 * source * bg,
				getLuminance(source)
				// getSaturation(bg) * getLuminance(source)
			);
		}

		inline function mixSoftOverlay(source:Vec3, bg:Vec3) : Vec3 {
			return mix(
				bg,
				2.0 * source * bg,
				getSaturation(bg) * getLuminance(source)
			);
		}

		inline function bgHardLight(source:Vec3, bg:Vec3) : Vec3 {
			return 1.0 - 2.0 * (1.0 - source) * (1.0 - bg);
		}

		function fragment() {
			var sourceColor = texture.get(input.uv);
			pixelColor.rgba = vec4(
				mixOverlay( sourceColor.rgb, bg.get(input.uv).rgb ),
				sourceColor.a
			);
		}
	};

	public function new(bgTexture:h3d.mat.Texture) {
		super();
		this.bg = bgTexture;
	}
}