class ExperimentalFilter extends h2d.filter.Shader<InternalShader> {
	public function new(lightMap:h3d.mat.Texture, shadowGradientMap:h3d.mat.Texture, intensity=1.0) {
		var s = new InternalShader();
		s.lightMap = lightMap;
		s.gradientMap = shadowGradientMap;
		s.intensity = M.fclamp(intensity,0,1);
		s.pixelSize = 1/lightMap.width;

		super(s);
	}

	public inline function useLightMap(t, disposePrevious=true) {
		if( disposePrevious )
			shader.lightMap.dispose();
		shader.lightMap = t;
	}

	override function sync(ctx:h2d.RenderContext, s:h2d.Object) {
		super.sync(ctx, s);
		shader.time = hxd.Timer.frameCount;
	}

}


// --- Shader -------------------------------------------------------------------------------
private class InternalShader extends h3d.shader.ScreenShader {
	static var SRC = {
		@param var texture : Sampler2D;
		@param var lightMap : Sampler2D;
		@param var gradientMap : Sampler2D;
		@param var intensity : Float;
		@param var pixelSize : Float;
		@param var time : Float;

		inline function getLum(col:Vec3) : Float {
			return col.rgb.dot( vec3(0.2126, 0.7152, 0.0722) );
		}

		function fragment() {
			// Get light intensity
			var lightPixel = lightMap.get(calculatedUV);
			var lightPow = lightPixel.r;

			// Offset UV in darkness
			calculatedUV.x += (1-lightPow) * pixelSize*0.8 * sin(calculatedUV.x*19 + time*0.03);
			calculatedUV.y += (1-lightPow) * pixelSize*1 * cos(calculatedUV.y*16 + time*0.02);

			// Colorize darkness
			var pixel : Vec4 = texture.get(calculatedUV);
			var luminance = getLum(pixel.rgb);
			var rep = gradientMap.get( vec2(luminance, 0) );
			pixelColor = vec4( pixel.rgb*lightPow + rep.rgb*(1-lightPow), pixel.a );
		}
	};
}
