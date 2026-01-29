package model.Expressions;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyHeapInterface;
import model.Types.Type;
import model.Values.Value;

public interface Expression {
    Value evaluate(MyDictionaryInterface<String, Value> table, MyHeapInterface<Value> heap) throws InterpreterException;
    Expression deepCopy();
    Type typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException;
}
