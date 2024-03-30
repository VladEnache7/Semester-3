package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.Expressions.Expression;
import model.ProgramState;
import model.Types.StringType;
import model.Types.Type;
import model.Values.StringValue;
import model.Values.Value;

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
                throw new InterpreterException("File is already opened");
            else {
                try {
                    BufferedReader reader = new BufferedReader(new java.io.FileReader(stringValue.getValue()));
                    fileTable.add(stringValue, reader);
                } catch (java.io.IOException exception) {
                    throw new InterpreterException("File cannot be opened " + exception.getMessage());
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
