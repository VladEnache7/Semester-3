package com.example.toylanguage6.model.Expressions;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyHeapInterface;
import com.example.toylanguage6.model.Types.BoolType;
import com.example.toylanguage6.model.Types.IntType;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.BoolValue;
import com.example.toylanguage6.model.Values.IntValue;
import com.example.toylanguage6.model.Values.Value;

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
            throw new InterpreterException("RelationalExpression: The first expression from the RelationalExpression is not an integer");
        }
        Value value2 = expression2.evaluate(symbolTable, heap);
        if (!value2.getType().equals(new IntType())){
            throw new InterpreterException("RelationalExpression: The second expression from the RelationalExpression is not an integer");
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
            default -> throw new InterpreterException("RelationalExpression: Invalid relational operator");
        }
    }

    @Override
    public Expression deepCopy() {
        return new RelationalExpression(this.relation, this.expression1.deepCopy(), this.expression2.deepCopy());
    }

    @Override
    public Type typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        Type type1 = expression1.typeCheck(typeEnvironment);
        Type type2 = expression2.typeCheck(typeEnvironment);
        if (type1.equals(new IntType())){
            if (type2.equals(new IntType())){
                return new BoolType();
            } else {
                throw new InterpreterException("RelationalExpression: Second operand is not an integer!");
            }
        } else {
            throw new InterpreterException("RelationalExpression: First operand is not an integer!");
        }
    }

    @Override
    public String toString(){
        return expression1.toString() + " " + relation + " " + expression2.toString();
    }
}
