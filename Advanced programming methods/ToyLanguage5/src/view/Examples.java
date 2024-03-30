package view;

import model.Expressions.*;
import model.Statements.*;
import model.Types.BoolType;
import model.Types.IntType;
import model.Types.RefType;
import model.Types.StringType;
import model.Values.BoolValue;
import model.Values.IntValue;
import model.Values.StringValue;

public class Examples {
    // int v; v = 2; Print(v)
    /*This is the correct one*/
    /*static StatementInterface example1 = new CompoundStatement(
            new VariableDeclarationStatement("v", new IntType()),
            new CompoundStatement(
                    new AssignStatement("v", new ValueExpression(new IntValue(2))),
                    new PrintStatement(new VariableExpression("v"))
            )
    );*/
    /*This is the wrong one to check if the type checker works properly*/
    static StatementInterface example1 = new CompoundStatement(
            new VariableDeclarationStatement("v", new IntType()),
            new CompoundStatement(
                    new AssignStatement("v", new ValueExpression(new BoolValue(true))),
                    new PrintStatement(new VariableExpression("v"))
            )
    );
    // int a; int b; a = 2 + 3 * 5; b = a + 1; Print(b)
    static StatementInterface example2 = new CompoundStatement(
            new VariableDeclarationStatement("a", new IntType()),
            new CompoundStatement(
                    new VariableDeclarationStatement("b", new IntType()),
                    new CompoundStatement(
                            new AssignStatement(
                                    "a",
                                    new ArithmeticExpression(
                                            '+',
                                            new ValueExpression(new IntValue(2)),
                                            new ArithmeticExpression('*',
                                                    new ValueExpression(new IntValue(3)),
                                                    new ValueExpression(new IntValue(5))
                                            )
                                    )
                            ),
                            new CompoundStatement(
                                    new AssignStatement(
                                            "b",
                                            new ArithmeticExpression('+',
                                                    new VariableExpression("a"),
                                                    new ValueExpression(new IntValue(1))
                                            )
                                    ),
                                    new PrintStatement(new VariableExpression("b"))
                            )
                    )
            )
    );
    // bool a; int v; a = true; (If a Then v = 2 Else v = 3); Print(v)
    static StatementInterface example3 = new CompoundStatement(
            new VariableDeclarationStatement("a", new BoolType()),
            new CompoundStatement(
                    new VariableDeclarationStatement("v", new IntType()),
                    new CompoundStatement(
                            new AssignStatement("a", new ValueExpression(new BoolValue(true))),
                            new CompoundStatement(
                                    new IfStatement(
                                            new VariableExpression("a"),
                                            new AssignStatement("v", new ValueExpression(new IntValue(2))),
                                            new AssignStatement("v", new ValueExpression(new IntValue(3)))
                                    ),
                                    new PrintStatement(new VariableExpression("v"))
                            )
                    )
            )
    );
    // string varf; varf = "test.in"; openRFile(varf); int varc; readFile(varf, varc); print(varc); readFile(varf, varc); print(varc); closeRFile(varf)
    static StatementInterface example4 = new CompoundStatement(
            new VariableDeclarationStatement("varf", new StringType()),
            new CompoundStatement(
                    new AssignStatement("varf", new ValueExpression(new StringValue("test.in"))),
                    new CompoundStatement(
                            new OpenReadFileStatement(new VariableExpression("varf")),
                            new CompoundStatement(
                                    new VariableDeclarationStatement("varc", new IntType()),
                                    new CompoundStatement(
                                            new ReadFileStatement(new VariableExpression("varf"), "varc"),
                                            new CompoundStatement(
                                                    new PrintStatement(new VariableExpression("varc")),
                                                    new CompoundStatement(
                                                            new ReadFileStatement(new VariableExpression("varf"), "varc"),
                                                            new CompoundStatement(
                                                                    new PrintStatement(new VariableExpression("varc")),
                                                                    new CloseReadFileStatement(new VariableExpression("varf"))
                                                            )
                                                    )
                                            )
                                    )
                            )
                    )
            )
    );

    // Ref int v;new(v,20);Ref Ref int a; new(a,v);print(v);print(a)
    static StatementInterface example5 = new CompoundStatement(
            new VariableDeclarationStatement("v", new RefType(new IntType())),
            new CompoundStatement(
                    new HeapAllocationStatement("v", new ValueExpression(new IntValue(20))),
                    new CompoundStatement(
                            new VariableDeclarationStatement("a", new RefType(new RefType(new IntType()))),
                            new CompoundStatement(
                                    new HeapAllocationStatement("a", new VariableExpression("v")),
                                    new CompoundStatement(
                                            new PrintStatement(new VariableExpression("v")),
                                            new PrintStatement(new VariableExpression("a"))
                                    )
                            )
                    )
            )
    );

    //  Ref int v;new(v,20);Ref Ref int a; new(a,v);print(rH(v));print(rH(rH(a))+5)
    static StatementInterface example6 = new CompoundStatement(
            new VariableDeclarationStatement("v", new RefType(new IntType())),
            new CompoundStatement(
                    new HeapAllocationStatement("v", new ValueExpression(new IntValue(20))),
                    new CompoundStatement(
                            new VariableDeclarationStatement("a", new RefType(new RefType(new IntType()))),
                            new CompoundStatement(
                                    new HeapAllocationStatement("a", new VariableExpression("v")),
                                    new CompoundStatement(
                                            new PrintStatement(new HeapReadingExpression(new VariableExpression("v"))),
                                            new PrintStatement(new ArithmeticExpression('+',
                                                    new HeapReadingExpression(new HeapReadingExpression(new VariableExpression("a"))),
                                                    new ValueExpression(new IntValue(5))
                                            ))
                                    )
                            )
                    )
            )
    );

    //  Ref int v;new(v,20);print(rH(v)); wH(v,30);print(rH(v)+5);
    static StatementInterface example7 = new CompoundStatement(
            new VariableDeclarationStatement("v", new RefType(new IntType())),
            new CompoundStatement(
                    new HeapAllocationStatement("v", new ValueExpression(new IntValue(20))),
                    new CompoundStatement(
                            new PrintStatement(new HeapReadingExpression(new VariableExpression("v"))),
                            new CompoundStatement(
                                    new HeapWritingStatement("v", new ValueExpression(new IntValue(30))),
                                    new PrintStatement(new ArithmeticExpression('+',
                                            new HeapReadingExpression(new VariableExpression("v")),
                                            new ValueExpression(new IntValue(5))
                                    ))
                            )
                    )
            )
    );

    //  int v; v=4; (while (v>0) print(v);v=v-1);print(v)
    static StatementInterface example8 = new CompoundStatement(
            new VariableDeclarationStatement("v", new IntType()),
            new CompoundStatement(
                    new AssignStatement("v", new ValueExpression(new IntValue(4))),
                    new CompoundStatement(
                            new WhileStatement(
                                    new RelationalExpression(
                                            ">",
                                            new VariableExpression("v"),
                                            new ValueExpression(new IntValue(0))
                                    ),
                                    new CompoundStatement(
                                            new PrintStatement(new VariableExpression("v")),
                                            new AssignStatement(
                                                    "v",
                                                    new ArithmeticExpression(
                                                            '-',
                                                            new VariableExpression("v"),
                                                            new ValueExpression(new IntValue(1))
                                                    )
                                            )
                                    )
                            ),
                            new PrintStatement(new VariableExpression("v"))
                    )
            )
    );
    // int v; Ref int a; v=10;new(a,22);
    // fork(wH(a,30);v=32;print(v);print(rH(a)));
    // print(v);print(rH(a))
    static StatementInterface example9 = new CompoundStatement(
            new VariableDeclarationStatement("v", new IntType()),
            new CompoundStatement(
                    new VariableDeclarationStatement("a", new RefType(new IntType())),
                    new CompoundStatement(
                            new AssignStatement("v", new ValueExpression(new IntValue(10))),
                            new CompoundStatement(
                                    new HeapAllocationStatement("a", new ValueExpression(new IntValue(22))),
                                    new CompoundStatement(
                                            new ForkStatement(
                                                    new CompoundStatement(
                                                            new HeapWritingStatement("a", new ValueExpression(new IntValue(30))),
                                                            new CompoundStatement(
                                                                    new AssignStatement("v", new ValueExpression(new IntValue(32))),
                                                                    new CompoundStatement(
                                                                            new PrintStatement(new VariableExpression("v")),
                                                                            new PrintStatement(new HeapReadingExpression(new VariableExpression("a")))
                                                                    )
                                                            )
                                                    )
                                            ),
                                            new CompoundStatement(
                                                    new PrintStatement(new VariableExpression("v")),
                                                    new PrintStatement(new HeapReadingExpression(new VariableExpression("a")))
                                            )
                                    )
                            )
                    )
            )
    );

    public static StatementInterface[] exampleList(){
        return new StatementInterface[]{example1, example2, example3, example4, example5, example6, example7, example8, example9};
    }
}
