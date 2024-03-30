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

public class CloseReadFileStatement implements StatementInterface {
    private final Expression expression;

    public CloseReadFileStatement(Expression expression) {
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyDictionaryInterface<String, Value> symbolTable = state.getSymbolTable();
        MyDictionaryInterface<StringValue, BufferedReader> fileTable = state.getFileTable();
        if(!expression.evaluate(symbolTable, state.getHeap()).getType().equals(new StringType()))
            throw new InterpreterException("CloseReadFile expression is not a string");
        StringValue stringValue = (StringValue) expression.evaluate(symbolTable, state.getHeap()); // downcasting
        if(!fileTable.isDefined(stringValue))
            throw new InterpreterException("CloseReadFileStatement: File is not defined in the file table");
        // close the file
        try {
            fileTable.lookup(stringValue).close();
            fileTable.remove(stringValue);
        } catch (java.io.IOException exception) {
            throw new InterpreterException("CloseReadFileStatement: File cannot be closed " + exception.getMessage());
        }
        state.setFileTable(fileTable);
        return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new CloseReadFileStatement(expression.deepCopy());
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        Type typeExpression = expression.typeCheck(typeEnvironment);
        if(!typeExpression.equals(new StringType()))
            throw new InterpreterException("CloseReadFile expression is not a string");
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "closeFile(" + expression.toString() + ")";
    }
}
