package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyHeapInterface;
import model.Expressions.Expression;
import model.ProgramState;
import model.Types.RefType;
import model.Types.Type;
import model.Values.RefValue;
import model.Values.Value;

public class HeapAllocationStatement implements StatementInterface {
    private final String varName;
    private final Expression expression;

    public HeapAllocationStatement(String varName, Expression expression) {
        this.varName = varName;
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyDictionaryInterface<String, Value> symbolTable = state.getSymbolTable();
        MyHeapInterface<Value> heap = state.getHeap();

        if(!symbolTable.isDefined(varName))
            throw new InterpreterException("The variable " + varName + " is not defined in the symbol table!");
        if(! (symbolTable.lookup(varName).getType() instanceof RefType))
            throw new InterpreterException("The variable " + varName + " is not of type RefType!");
        Value newValue = expression.evaluate(symbolTable, heap);
        Value tableVal = symbolTable.lookup(varName);
        if(!newValue.getType().equals(((RefType)tableVal.getType()).getInner()))
            throw new InterpreterException("The type of the expression is not the same as the type of the variable!");

        int addr = heap.allocate(newValue);
        symbolTable.update(this.varName, new RefValue(addr, newValue.getType()));

        state.setSymbolTable(symbolTable);
        state.setHeap(heap);
        ////return state; 
    return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new HeapAllocationStatement(varName, expression.deepCopy());
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        Type typeVar = typeEnvironment.lookup(varName);
        Type typeExpr = expression.typeCheck(typeEnvironment);
        if(typeVar.equals(new RefType(typeExpr)))
            return typeEnvironment;
        else
            throw new InterpreterException("The type of the variable and the type of the expression do not match!");
    }

    @Override
    public String toString() {
        return "new(" + varName + ", " + expression.toString() + ")";
    }
}
