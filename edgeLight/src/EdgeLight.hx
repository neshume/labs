// --- Filter -------------------------------------------------------------------------------
class EdgeLight extends h2d.filter.Filter {
	public var color32(default, set) : Int;
	public var ang(default, set) : Float;
	var pass : EdgeLightPass;

	public function new(color32:Int, ang:Float) {
		super();
		pass = new EdgeLightPass(color32, ang);
		this.color32 = color32;
		smooth = false;
	}

	inline function set_color32(v:Int) {
		color32 = v;
		pass.color = color32;
		return v;
	}

	inline function set_ang(v:Float) {
		ang = v;
		pass.ang = v;
		return v;
	}

	override function sync(ctx : h2d.RenderContext, s : h2d.Object) {
		boundsExtend = 1;
	}

	override function draw(ctx : h2d.RenderContext, t : h2d.Tile) {
		var out = ctx.textures.allocTileTarget("colorMatrixOut", t);
		pass.apply(t.getTexture(), out);
		return h2d.Tile.fromTexture(out);
	}
}


// --- H3D pass -------------------------------------------------------------------------------
@ignore("shader")
private class EdgeLightPass extends h3d.pass.ScreenFx<EdgeLightShader> {
	public var color(default, set) : Int;
	public var ang(default, set) : Float;

	public function new(color:Int, ang:Float) {
		super(new EdgeLightShader());
		this.color = color;
		this.ang = ang;
	}

	function set_color(c) {
		if( color==c )
			return c;
		return color = c;
	}

	function set_ang(v) {
		if( ang==v )
			return v;
		return ang = v;
	}

	public function apply(src:h3d.mat.Texture, out:h3d.mat.Texture) {
		engine.pushTarget(out);

		shader.texture = src;
		shader.lightColor.setColor(color);
		shader.lightAng = ang;
		shader.pixelSize.set(1/src.width, 1/src.height);
		render();

		engine.popTarget();
	}

}

// --- Shader -------------------------------------------------------------------------------
private class EdgeLightShader extends h3d.shader.ScreenShader {
	static var SRC = {
		@param var texture : Sampler2D;
		@param var pixelSize : Vec2;
		@param var lightColor : Vec4;
		@param var lightAng : Float;

		function normalizeRad(a:Float) : Float {
			var out = a;
			while( out<-PI ) out+=PI*2;
			while( out>PI ) out-=PI*2;
			return out;
		}

		function radDistance(a:Float, b:Float) : Float {
			return abs( normalizeRad( normalizeRad(a)-normalizeRad(b) ) );
		}

		function fragment() {
			var curColor : Vec4 = texture.get(input.uv);

			if( curColor.a==0 || lightColor.a==0 )
				output.color = curColor;
			else {
				if( texture.get( vec2(input.uv.x + pixelSize.x, input.uv.y) ).a==0
				 || texture.get( vec2(input.uv.x - pixelSize.x, input.uv.y) ).a==0
				 || texture.get( vec2(input.uv.x, input.uv.y+pixelSize.y) ).a==0
				 || texture.get( vec2(input.uv.x, input.uv.y-pixelSize.y) ).a==0 ) {
					var pow : Float = 0;
					if( texture.get( vec2(input.uv.x, input.uv.y-pixelSize.y) ).a==0 )
						pow += 1 - min( radDistance(lightAng,-PI/2) / (PI/2), 1 );

					if( texture.get( vec2(input.uv.x, input.uv.y+pixelSize.y) ).a==0 )
						pow += 1 - min( radDistance(lightAng,PI/2) / (PI/2), 1 );

					if( texture.get( vec2(input.uv.x-pixelSize.x, input.uv.y) ).a==0 )
						pow += 1 - min( radDistance(lightAng,PI) / (PI/2), 1 );

					if( texture.get( vec2(input.uv.x+pixelSize.x, input.uv.y) ).a==0 )
						pow += 1 - min( radDistance(lightAng,0) / (PI/2), 1 );

					pow*=lightColor.a;
					output.color = vec4( lightColor.rgb*pow + curColor.rgb*(1-pow), curColor.a );
				}
				else {
					output.color = curColor;
				}
			// var norm = vec2(
			// 		( texture.get(vec2(input.uv.x + pixelSize.x, input.uv.y) ).a==0 ? 1 : 0 )
			// 		+ ( texture.get( vec2(input.uv.x - pixelSize.x, input.uv.y) ).a==0 ? -1 : 0 ),
			// 		( texture.get(vec2(input.uv.x, input.uv.y + pixelSize.y) ).a==0 ? 1 : 0 )
			// 		+ ( texture.get( vec2(input.uv.x, input.uv.y - pixelSize.y) ).a==0 ? -1 : 0 )
			// 	);
			// 	output.color = vec4(lightColor, curColor.a);
			}

			// 	if( texture.get( vec2(input.uv.x + pixelSize.x, input.uv.y) ).a!=0
			// 	 || texture.get( vec2(input.uv.x - pixelSize.x, input.uv.y) ).a!=0
			// 	 || texture.get( vec2(input.uv.x, input.uv.y+pixelSize.y) ).a!=0
			// 	 || texture.get( vec2(input.uv.x, input.uv.y-pixelSize.y) ).a!=0 )
			// 		output.color = vec4(outlineColor, 1);
			// 	else
			// 		output.color = curColor;
			// }
			// else
			// 	output.color = curColor;
			// if( curColor.a==0 ) {
			// 	if( texture.get( vec2(input.uv.x + pixelSize.x, input.uv.y) ).a!=0
			// 	 || texture.get( vec2(input.uv.x - pixelSize.x, input.uv.y) ).a!=0
			// 	 || texture.get( vec2(input.uv.x, input.uv.y+pixelSize.y) ).a!=0
			// 	 || texture.get( vec2(input.uv.x, input.uv.y-pixelSize.y) ).a!=0 )
			// 		output.color = vec4(outlineColor, 1);
			// 	else
			// 		output.color = curColor;
			// }
			// else
			// 	output.color = curColor;
		}
	};
}