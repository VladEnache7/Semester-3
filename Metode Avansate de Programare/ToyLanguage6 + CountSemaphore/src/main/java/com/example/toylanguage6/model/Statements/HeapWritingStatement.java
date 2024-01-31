package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyHeapInterface;
import com.example.toylanguage6.model.Expressions.Expression;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.RefType;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.Value;
import com.example.toylanguage6.model.Values.RefValue;

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
        if (!typeEnvironment.isDefined(this.varName)) {
            throw new InterpreterException("The variable " + this.varName + " is not defined!");
        }

        Type typeVar = typeEnvironment.lookup(this.varName);
        Type typeExpr = this.expression.typeCheck(typeEnvironment);
        if(typeVar.equals(new RefType(typeExpr)))
            return typeEnvironment;
        else
            throw new InterpreterException("The type of the variable and the type of the expression do not match!");
    }
}
