package model.Expressions;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyHeapInterface;
import model.Types.Type;
import model.Values.Value;

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
