package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.Expressions.Expression;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.StringType;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.StringValue;
import com.example.toylanguage6.model.Values.Value;

import java.io.BufferedReader;

public class OpenReadFileStatement implements StatementInterface {
    private final Expression expression;

    public OpenReadFileStatement(Expression expression) {
        this.expression = expression;
    }
    public String toString(){
        return "open(" + this.expression.toString() + ")";
    }
    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyDictionaryInterface<String, Value> symbolTable = state.getSymbolTable();
        MyDictionaryInterface<StringValue, BufferedReader> fileTable = state.getFileTable();
        Value value = expression.evaluate(symbolTable, state.getHeap());
        if(value.getType().equals(new StringType())){
            StringValue stringValue = (StringValue) value;
            if(fileTable.isDefined(stringValue))
                throw new InterpreterException("OpenReadFileStatement: File is already opened");
            else {
                try {
                    BufferedReader reader = new BufferedReader(new java.io.FileReader(stringValue.getValue()));
                    fileTable.add(stringValue, reader);
                } catch (java.io.IOException exception) {
                    throw new InterpreterException("OpenReadFileStatement: File cannot be opened " + exception.getMessage());
                }
            }
        } else
            throw new InterpreterException("OpenReadFile expression is not a string");
        state.setFileTable(fileTable);
        //return state; 
    return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new OpenReadFileStatement(expression);
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        Type typeExpression = expression.typeCheck(typeEnvironment);
        if(!typeExpression.equals(new StringType()))
            throw new InterpreterException("OpenReadFile expression is not a string");
        return typeEnvironment;
    }
}
