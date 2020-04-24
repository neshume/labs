import dn.FilePath as FP;

class Main extends hxd.App {
	public static var ME : Main;

	// Boot
	static function main() new Main();

	// Engine ready
	override function init() {
		ME = this;

		test("");
		test("/project.seb/rpgmap");
		test("/project.seb/rpgmap/");
		test("//project.seb//rpgmap/");
		test("/project.seb/rpgmap/LICENSE.md");
		test("/project.seb/rpgmap/test.png");
		test("/project.seb/rpgmap/another.test.png");
		test("c:\\windows\\system\\test.dll");

		hxd.System.exit();
	}

	function test(path:String) {
		trace("TESTING "+path);
		trace( FP.fromFile(path).debug() );
		trace( "dirSlash (noFile=false)="+FP.getDirWithSlash(path,false) );
		trace( "dirSlash (noFile=true)="+FP.getDirWithSlash(path,true) );
		trace( "file="+FP.getFile(path) );
		trace( "ext="+FP.getExt(path) );
		trace( "fileExt="+FP.getFileWithExt(path) );

		var p = FP.fromFile(path);
		p.fileWithExt = "override.json";
		trace("override="+p.full);
		trace("");
	}

	override function update(deltaTime:Float) {
		super.update(deltaTime);
	}
}

