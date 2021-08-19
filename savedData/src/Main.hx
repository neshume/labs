import dn.data.SavedData;

enum SavedEnum {
	None;
	Pouet;
	Foo;
	Bar;
}

typedef MySave = {
	var s : String;
	var i : Int;
	var f : Float;
	var b : Bool;
	var arr: Array<String>;
	var sub : {
		s : String,
		enu : SavedEnum,
		map : Map<String,Int>,
	}
}

class Main extends hxd.App {
	public static var ME : Main;

	// Boot
	static function main() new Main();

	// Engine ready
	override function init() {
		ME = this;

		var def : MySave = {
			s: "",
			i: 0,
			f: 0.,
			b: false,
			arr: [],
			sub: {
				s: "",
				enu: None,
				map: [ "init"=>-1 ],
			}
		}

		var s : MySave = {
			s: "hello",
			i: 14,
			f: 1.2,
			b: true,
			arr: ["a","b","c"],
			sub: {
				s: "world",
				enu: Bar,
				map: [ "a"=>1, "b"=>2 ],
			}
		}

		var format : SaveFormat = Serialized;
		SavedData.DEFAULT_SAVE_FOLDER = "save/"+format.getName();

		SavedData.save("test", s, format);

		var load = SavedData.load("old", def, format);
		SavedData.save("oldUpdated", load, format);
		var upd = SavedData.load("oldUpdated", def, format);
	}
}

