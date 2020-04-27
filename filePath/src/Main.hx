import dn.FilePath as FP;

class Main extends hxd.App {
	public static var ME : Main;

	// Boot
	static function main() new Main();

	// Engine ready
	override function init() {
		ME = this;

		test("../test.png");
		test("/project.seb/rpgmap/myApp.isCool.exe");
		test("c:\\windows\\system\\test.dll");

		hxd.System.exit();
	}

	function test(path:String) {
		trace("______________________________");
		trace("TESTING "+path);
		trace( FP.fromFile(path).debug() );
		trace( "dirSlash (noFile=false)="+FP.extractDirWithSlash(path,false) );
		trace( "dirSlash (noFile=true)="+FP.extractDirNoSlash(path,true) );
		trace( "file="+FP.extractFileName(path) );
		trace( "ext="+FP.extractExtension(path) );
		trace( "fileExt="+FP.extractFileWithExt(path) );

		var p = FP.fromFile(path);
		p.fileWithExt = "override.json";
		trace("override="+p.full);
	}

	override function update(deltaTime:Float) {
		super.update(deltaTime);
	}
}

