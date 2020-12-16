class ExperimentalFilter extends h2d.filter.Shader<InternalShader> {
	public function new() {
		var s = new InternalShader();
		super(s);
	}

	override function draw(ctx:h2d.RenderContext, t:h2d.Tile):h2d.Tile {
		shader.texelSize.set( 1/t.width, 1/t.height );
		return super.draw(ctx, t);
	}
}


// --- Shader -------------------------------------------------------------------------------
private class InternalShader extends h3d.shader.ScreenShader {
	static var SRC = {
		@param var texture : Sampler2D;
		@param var texelSize : Vec2;

		inline function getLum(col:Vec4) : Float {
			return col.rgb.dot( vec3(0.2126, 0.7152, 0.0722) );
		}

		inline function getContrast(c1:Vec4, c2:Vec4) : Float {
			var lum1 = getLum(c1);
			var lum2 = getLum(c2);
			return ( max(lum1,lum2) + 0.05 ) / ( min(lum1,lum2) + 0.05 );
		}

		function fragment() {
			var uv = calculatedUV;
			var curColor = texture.get(uv);

			var above = texture.get( vec2(uv.x, uv.y-texelSize.y) );
			var left = texture.get( vec2(uv.x-texelSize.x, uv.y) );
			var threshold = 1.8;
			var edgeMul = min( 1,
				( 1 - step( getContrast(curColor,above), threshold ) )
				+ ( 1 - step( getContrast(curColor,left), threshold ) )
			);

			pixelColor = vec4( curColor.rgb*edgeMul, curColor.a );
		}
	};
}
