package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.Expressions.Expression;
import model.ProgramState;
import model.Types.StringType;
import model.Values.StringValue;
import model.Values.Value;

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
        if(!expression.evaluate(symbolTable).getType().equals(new StringType()))
            throw new InterpreterException("CloseReadFile expression is not a string");
        StringValue stringValue = (StringValue) expression.evaluate(symbolTable); // downcasting
        if(!fileTable.isDefined(stringValue))
            throw new InterpreterException("File is not defined in the file table");
        // close the file
        try {
            fileTable.lookup(stringValue).close();
            fileTable.remove(stringValue);
        } catch (java.io.IOException exception) {
            throw new InterpreterException("File cannot be closed " + exception.getMessage());
        }
        state.setFileTable(fileTable);
        return state;
    }

    @Override
    public StatementInterface deepCopy() {
        return new CloseReadFileStatement(expression.deepCopy());
    }

    @Override
    public String toString() {
        return "closeFile(" + expression.toString() + ")";
    }
}
