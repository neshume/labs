import haxe.macro.Expr;

class Test {
	static var someStr = "hello";
	static var someInt = 2;

	public static macro function get(type:Expr) {
		return switch type.expr {
			case EConst( CIdent("String") ): macro $v{someStr};
			case EConst( CIdent("Int") ): macro $v{someInt};
			case _: macro null;
		}
	}
}