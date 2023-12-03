package model.Expressions;

import model.Values.Value;
import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;

public interface Expression {
    Value evaluate(MyDictionaryInterface<String, Value> table) throws InterpreterException;
    Expression deepCopy();
}
