package com.example.toylanguage6.model.Expressions;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyHeapInterface;
import com.example.toylanguage6.model.ADTs.MyListInterface;
import com.example.toylanguage6.model.Types.IntType;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.IntValue;
import com.example.toylanguage6.model.Values.Value;

public class ArithmeticExpression implements Expression {
    private final char operator;
    private final Expression expression1;
    private final Expression expression2;

    public ArithmeticExpression(char operator, Expression expression1, Expression expression2) {
        this.operator = operator;
        this.expression1 = expression1;
        this.expression2 = expression2;
    }

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> symbolTable, MyHeapInterface<Value> heap) throws InterpreterException {
        Value value1, value2;
        value1 = expression1.evaluate(symbolTable, heap);
        if (value1.getType().equals(new IntType())){
            value2 = expression2.evaluate(symbolTable, heap);
            if (value2.getType().equals(new IntType())){
                int number1, number2;
                number1 = ((IntValue) value1).getValue();
                number2 = ((IntValue) value2).getValue();
                switch (operator){
                    case '+':
                        return new IntValue(number1 + number2);
                    case '-':
                        return new IntValue(number1 - number2);
                    case '*':
                        return new IntValue(number1 * number2);
                    case '/':
                        if (number2 == 0)
                            throw new InterpreterException("ArithmeticExpression: Division by zero!");
                        else
                            return new IntValue(number1 / number2);
                    default:
                        throw new InterpreterException("ArithmeticExpression: Invalid operator!");
                }
            } else
                throw new InterpreterException("ArithmeticExpression: Second operand is not an integer!");
        }
        else
            throw new InterpreterException("ArithmeticExpression: First operand is not an integer!");
    }

    @Override
    public Expression deepCopy() {
        return new ArithmeticExpression(operator, expression1.deepCopy(), expression2.deepCopy());
    }

    @Override
    public Type typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        Type type1, type2;
        type1 = expression1.typeCheck(typeEnvironment);
        type2 = expression2.typeCheck(typeEnvironment);
        if (type1.equals(new IntType())){
            if (type2.equals(new IntType())){
                return new IntType();
            } else
                throw new InterpreterException("ArithmeticExpression: Second operand is not an integer!");
        } else
            throw new InterpreterException("ArithmeticExpression: First operand is not an integer!");
    }

    @Override
    public String toString(){
        return expression1.toString() + " " + operator + " " + expression2.toString();
    }
}
