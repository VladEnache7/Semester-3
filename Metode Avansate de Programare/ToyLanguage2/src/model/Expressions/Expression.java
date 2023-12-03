package model.Expressions;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.Values.Value;

public interface Expression {
    Value evaluate(MyDictionaryInterface<String, Value> table) throws InterpreterException;
    Expression deepCopy();
}
