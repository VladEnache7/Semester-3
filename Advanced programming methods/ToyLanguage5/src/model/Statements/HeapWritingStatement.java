package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyHeapInterface;
import model.Expressions.Expression;
import model.ProgramState;
import model.Types.RefType;
import model.Types.Type;
import model.Values.Value;
import model.Values.RefValue;

public class HeapWritingStatement implements StatementInterface {
    private final String varName;
    private final Expression expression;

    public HeapWritingStatement(String varName, Expression expression) {
        this.varName = varName;
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyDictionaryInterface<String, Value> symbolTable = state.getSymbolTable();
        MyHeapInterface<Value> heap = state.getHeap();

        if (!symbolTable.isDefined(this.varName))
            throw new InterpreterException("Variable " + this.varName + " is not defined in symbolTable!");
        Value tableVal = symbolTable.lookup(this.varName);
        if (!(tableVal.getType() instanceof RefType))
            throw new InterpreterException("The value from SymbolTable doesn't have the type RefType!");

        int refAddress = ((RefValue)tableVal).getAddress();
        if (!heap.exists(refAddress))
            throw new InterpreterException("Value does not exist on heap");

        Value valExpr = this.expression.evaluate(symbolTable, heap);
        if(!valExpr.getType().equals(heap.get(refAddress).getType()))
            throw new InterpreterException("Expression not of variable type");

        heap.put(refAddress, valExpr);
        state.setSymbolTable(symbolTable);
        state.setHeap(heap);
        //return state; 
    return null;
    }

    @Override
    public String toString() {
        return "writeHeap(" + this.varName + ", " + this.expression.toString() + ")";
    }

    @Override
    public StatementInterface deepCopy() {
        return new HeapWritingStatement(this.varName, this.expression.deepCopy());
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        Type typeVar = typeEnvironment.lookup(this.varName);
        Type typeExpr = this.expression.typeCheck(typeEnvironment);
        if(typeVar.equals(new RefType(typeExpr)))
            return typeEnvironment;
        else
            throw new InterpreterException("The type of the variable and the type of the expression do not match!");
    }
}
