package model.Expressions;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyHeapInterface;
import model.Types.IntType;
import model.Values.BoolValue;
import model.Values.IntValue;
import model.Values.Value;

public class RelationalExpression implements Expression {
    private final String relation;
    private final Expression expression1;
    private final Expression expression2;

    public RelationalExpression(String relation, Expression expression1, Expression expression2) {
        this.relation = relation;
        this.expression1 = expression1;
        this.expression2 = expression2;
    }

    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> symbolTable, MyHeapInterface<Value> heap) throws InterpreterException {
        Value value1 = expression1.evaluate(symbolTable, heap);
        if (!value1.getType().equals(new IntType())){
            throw new InterpreterException("The first expression from the RelationalExpression is not an integer");
        }
        Value value2 = expression2.evaluate(symbolTable, heap);
        if (!value2.getType().equals(new IntType())){
            throw new InterpreterException("The second expression from the RelationalExpression is not an integer");
        }

        // down casting the values to IntValue
        IntValue intValue1 = (IntValue) value1;
        IntValue intValue2 = (IntValue) value2;
        int int1 = intValue1.getValue();
        int int2 = intValue2.getValue();

        switch (relation) {
            case "<" -> {return new BoolValue(int1 < int2);}
            case "<=" -> {return new BoolValue(int1 <= int2);}
            case "==" -> {return new BoolValue(int1 == int2);}
            case "!=" -> {return new BoolValue(int1 != int2);}
            case ">" -> {return new BoolValue(int1 > int2);}
            case ">=" -> {return new BoolValue(int1 >= int2);}
            default -> throw new InterpreterException("Invalid relational operator");
        }
    }

    @Override
    public Expression deepCopy() {
        return new RelationalExpression(this.relation, this.expression1.deepCopy(), this.expression2.deepCopy());
    }

    @Override
    public String toString(){
        return expression1.toString() + " " + relation + " " + expression2.toString();
    }
}
