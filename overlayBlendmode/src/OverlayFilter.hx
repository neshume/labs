class OverlayFilter extends h2d.filter.Filter {
	var pass : OverlayPass;

	public function new(c:UInt) {
		super();
		pass = new OverlayPass(c);
	}

	override function draw( ctx : h2d.RenderContext, t : h2d.Tile ) {
		var tout = ctx.textures.allocTileTarget("overlayOut", t);
		pass.apply(t.getTexture(), tout);
		return h2d.Tile.fromTexture(tout);
	}
}