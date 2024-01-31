package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyHeapInterface;
import com.example.toylanguage6.model.Expressions.Expression;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.RefType;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.RefValue;
import com.example.toylanguage6.model.Values.Value;

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
            throw new InterpreterException("HeapAllocationStatement: The variable " + varName + " is not defined in the symbol table!");
        if(! (symbolTable.lookup(varName).getType() instanceof RefType))
            throw new InterpreterException("HeapAllocationStatement: The variable " + varName + " is not of type RefType!");
        Value newValue = expression.evaluate(symbolTable, heap);
        Value tableVal = symbolTable.lookup(varName);
        if(!newValue.getType().equals(((RefType)tableVal.getType()).getInner()))
            throw new InterpreterException("HeapAllocationStatement: The type of the expression is not the same as the type of the variable!");

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
            throw new InterpreterException("HeapAllocationStatement: The type of the variable and the type of the expression do not match!");
    }

    @Override
    public String toString() {
        return "new(" + varName + ", " + expression.toString() + ")";
    }
}
