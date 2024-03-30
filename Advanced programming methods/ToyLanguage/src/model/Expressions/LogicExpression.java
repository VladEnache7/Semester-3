package model.Expressions;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.Types.BoolType;
import model.Values.BoolValue;
import model.Values.Value;

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
    public Value evaluate(MyDictionaryInterface<String, Value> table) throws InterpreterException {
        Value value1, value2;
        value1 = expression1.evaluate(table);

        if (value1.getType().equals(new BoolType())){
            value2 = expression2.evaluate(table);
            if (value2.getType().equals(new BoolType())){
                boolean boolean1, boolean2;
                boolean1 = ((BoolValue) value1).getValue();
                boolean2 = ((BoolValue) value2).getValue();
                return switch (operator.toLowerCase()) {
                    case "and" -> new BoolValue(boolean1 && boolean2);
                    case "or" -> new BoolValue(boolean1 || boolean2);
                    default -> throw new InterpreterException("Invalid operator! Either 'and' or 'or'!");
                };
            } else {
                throw new InterpreterException("Second operand is not a boolean!");
            }
        } else {
            throw new InterpreterException("First operand is not a boolean!");
        }
    }

    @Override
    public Expression deepCopy() {
        return new LogicExpression(operator, expression1.deepCopy(), expression2.deepCopy());
    }

    @Override
    public String toString(){
        return expression1.toString() + " " + operator + " " + expression2.toString();
    }
}
