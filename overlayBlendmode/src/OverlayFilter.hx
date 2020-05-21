/** FILTER **/

class OverlayFilter extends h2d.filter.Filter {
	var pass : OverlayPass;

	public function new(bgTexture:h3d.mat.Texture) {
		super();
		pass = new OverlayPass(bgTexture);
	}

	override function draw( ctx : h2d.RenderContext, t : h2d.Tile ) {
		var tout = ctx.textures.allocTileTarget("overlayOut", t);
		pass.apply(t.getTexture(), tout);
		return h2d.Tile.fromTexture(tout);
	}
}

/*** PASS **/

private class OverlayPass extends h3d.pass.ScreenFx<OverlayShader> {

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

/** SHADER **/
private class OverlayShader extends h3d.shader.ScreenShader {

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
			);
		}

		// inline function mixSoftOverlay(source:Vec3, bg:Vec3) : Vec3 {
		// 	return mix(
		// 		bg,
		// 		2.0 * source * bg,
		// 		getSaturation(bg) * getLuminance(source)
		// 	);
		// }

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