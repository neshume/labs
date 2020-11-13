class Main {
	static function main() {
		trace( Std.parseInt("0xaabbccdd") ); // 2864434397
		trace( 0xaabbccdd ); // -1430532899
		trace( Std.parseInt("0xaabbccdd") == 0xaabbccdd ); // false
	}
}

