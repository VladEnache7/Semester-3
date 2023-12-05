package model.Expressions;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyHeapInterface;
import model.Types.Type;
import model.Values.Value;

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
