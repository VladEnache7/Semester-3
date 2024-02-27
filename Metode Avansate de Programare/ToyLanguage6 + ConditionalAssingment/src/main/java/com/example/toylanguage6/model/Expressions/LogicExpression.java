package com.example.toylanguage6.model.Expressions;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyHeapInterface;
import com.example.toylanguage6.model.Types.BoolType;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.BoolValue;
import com.example.toylanguage6.model.Values.Value;

public class LogicExpression implements Expression {
    private final String operator;
    private final Expression expression1;
    private final Expression expression2;


    public LogicExpression(String operator, Expression expression1, Expression expression2) {
        this.operator = operator;
        this.expression1 = expression1;
        this.expression2 = expression2;
    }

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> table, MyHeapInterface<Value> heap) throws InterpreterException {
        Value value1, value2;
        value1 = expression1.evaluate(table, heap);

        if (value1.getType().equals(new BoolType())){
            value2 = expression2.evaluate(table, heap);
            if (value2.getType().equals(new BoolType())){
                boolean boolean1, boolean2;
                boolean1 = ((BoolValue) value1).getValue();
                boolean2 = ((BoolValue) value2).getValue();
                return switch (operator.toLowerCase()) {
                    case "and" -> new BoolValue(boolean1 && boolean2);
                    case "or" -> new BoolValue(boolean1 || boolean2);
                    default -> throw new InterpreterException("LogicExpression: Invalid operator! Either 'and' or 'or'!");
                };
            } else {
                throw new InterpreterException("LogicExpression: Second operand is not a boolean!");
            }
        } else {
            throw new InterpreterException("LogicExpression: First operand is not a boolean!");
        }
    }

    @Override
    public Expression deepCopy() {
        return new LogicExpression(operator, expression1.deepCopy(), expression2.deepCopy());
    }

    @Override
    public Type typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        Type type1, type2;
        type1 = expression1.typeCheck(typeEnvironment);
        type2 = expression2.typeCheck(typeEnvironment);
        if (type1.equals(new BoolType())){
            if (type2.equals(new BoolType())){
                return new BoolType();
            } else {
                throw new InterpreterException("LogicExpression: Second operand is not a boolean!");
            }
        } else {
            throw new InterpreterException("LogicExpression: First operand is not a boolean!");
        }
    }

    @Override
    public String toString(){
        return expression1.toString() + " " + operator + " " + expression2.toString();
    }
}
