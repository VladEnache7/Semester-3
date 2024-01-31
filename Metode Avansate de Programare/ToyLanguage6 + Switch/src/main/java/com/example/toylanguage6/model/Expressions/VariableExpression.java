package com.example.toylanguage6.model.Expressions;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyHeapInterface;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.Value;

public class VariableExpression implements Expression {
    private final String id;

    public VariableExpression(String id) {
        this.id = id;
    }

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> symbolTable, MyHeapInterface<Value> heap) throws InterpreterException {
        return symbolTable.lookup(id);
    }

    @Override
    public Expression deepCopy() {
        return new VariableExpression(id);
    }

    @Override
    public String toString() {
        return id;
    }

    @Override
    public Type typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        return typeEnvironment.lookup(id);
    }
}
