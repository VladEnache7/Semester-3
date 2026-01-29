package com.example.toylanguage6.model.Expressions;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyHeapInterface;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.Value;

public class ValueExpression implements Expression {
    private final Value value;

    public ValueExpression(Value value) {
        this.value = value;
    }

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> table, MyHeapInterface<Value> heap) {
        return value;
    }

    @Override
    public Expression deepCopy() {
        return new ValueExpression(value.deepCopy());
    }

    @Override
    public String toString() {
        return value.toString();
    }

    @Override
    public Type typeCheck(MyDictionaryInterface<String, Type> table) throws InterpreterException {
        return this.value.getType();
    }
}
