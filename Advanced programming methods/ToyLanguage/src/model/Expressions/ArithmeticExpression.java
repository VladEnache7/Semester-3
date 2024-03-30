package model.Expressions;

import model.Types.IntType;
import model.Values.IntValue;
import model.Values.Value;
import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;

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
    public Value evaluate(MyDictionaryInterface<String, Value> symbolTable) throws InterpreterException {
        Value value1, value2;
        value1 = expression1.evaluate(symbolTable);
        if (value1.getType().equals(new IntType())){
            value2 = expression2.evaluate(symbolTable);
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
                            throw new InterpreterException("Division by zero!");
                        else
                            return new IntValue(number1 / number2);
                    default:
                        throw new InterpreterException("Invalid operator!");
                }
            } else
                throw new InterpreterException("Second operand is not an integer!");
        }
        else
            throw new InterpreterException("First operand is not an integer!");
    }

    @Override
    public Expression deepCopy() {
        return new ArithmeticExpression(operator, expression1.deepCopy(), expression2.deepCopy());
    }

    @Override
    public String toString(){
        return expression1.toString() + " " + operator + " " + expression2.toString();
    }
}
