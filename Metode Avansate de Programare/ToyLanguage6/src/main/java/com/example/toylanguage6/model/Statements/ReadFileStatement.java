package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.Expressions.Expression;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.IntType;
import com.example.toylanguage6.model.Types.StringType;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.IntValue;
import com.example.toylanguage6.model.Values.StringValue;
import com.example.toylanguage6.model.Values.Value;

public class ReadFileStatement implements StatementInterface {
    private final Expression expression;
    private final String varName;

    public ReadFileStatement(Expression expression, String varName) {
        this.expression = expression;
        this.varName = varName;
    }
    public String toString(){
        return "readFile(" + this.expression.toString() + ", " + this.varName + ")";
    }
    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyDictionaryInterface<String, Value> symbolTable = state.getSymbolTable();

        // if the variable name is not defined in the symbol table, throw an exception
        if(!symbolTable.isDefined(this.varName))
            throw new InterpreterException("ReadFileStatement: varName " + this.varName + " is not defined in symbol table");
        Value value = symbolTable.lookup(this.varName);

        // if the variable name is not an integer, throw an exception
        if (!value.getType().equals(new IntType()))
            throw new InterpreterException("ReadFileStatement: ReadFile value is not an integer");

        // evaluate the expressions
        Value valueExpression = expression.evaluate(symbolTable, state.getHeap());
        if(!valueExpression.getType().equals(new StringType()))
            throw new InterpreterException("ReadFileStatement: ReadFile expression's value type is not a string");

        // if the file is not defined in the file table, throw an exception
        StringValue stringValue = (StringValue) valueExpression;
        if(!state.getFileTable().isDefined(stringValue))
            throw new InterpreterException("ReadFileStatement: File is not defined in the file table");

        // read from the file
        try {
            String line = state.getFileTable().lookup(stringValue).readLine();
            if(line == null)
                symbolTable.update(this.varName, new IntType().getDefault());
            else
                symbolTable.update(this.varName, new IntValue(Integer.parseInt(line)));
        } catch (java.io.IOException exception) {
            throw new InterpreterException("ReadFileStatement: Cannot read from file");
        }
        state.setSymbolTable(symbolTable);
        //return state; 
    return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new ReadFileStatement(expression, varName);
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        Type typeExpression = expression.typeCheck(typeEnvironment);
        Type typeVar = typeEnvironment.lookup(varName);
        if(!typeExpression.equals(new StringType()))
            throw new InterpreterException("ReadFileStatement: ReadFile expression's value type is not a string");
        if(!typeVar.equals(new IntType()))
            throw new InterpreterException("ReadFileStatement: ReadFile value is not an integer");
        return typeEnvironment;
    }
}
