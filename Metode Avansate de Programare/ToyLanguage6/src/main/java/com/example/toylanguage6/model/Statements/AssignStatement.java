package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.Expressions.Expression;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.Value;

public class AssignStatement implements StatementInterface {
    private final String variableName;
    private final Expression expression;

    public AssignStatement(String variableName, Expression expression) {
        this.variableName = variableName;
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyDictionaryInterface<String, Value> symbolTable = state.getSymbolTable();

        if (symbolTable.isDefined(variableName)){
            Value value = expression.evaluate(symbolTable, state.getHeap());
            Type typeVariable = (symbolTable.lookup(variableName)).getType();
            if (value.getType().equals(typeVariable))
                symbolTable.update(variableName, value);
            else
                throw new InterpreterException("AssignStatement: Declared type of variable " + variableName + " and type of the assigned expression do not match!");

        } else
            throw new InterpreterException("AssignStatement: Variable " + variableName + " is not defined!");
        state.setSymbolTable(symbolTable);
        //return state; 
    return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new AssignStatement(variableName, expression.deepCopy());
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        //TODO: Add the check if the variable name is defined (maybe I forgot also this somewhere else)
        Type typeVariable = typeEnvironment.lookup(variableName);
        Type typeExpression = expression.typeCheck(typeEnvironment);
        if (typeVariable.equals(typeExpression))
            return typeEnvironment;
        else
            throw new InterpreterException("AssignStatement: Declared type of variable " + variableName + " and type of the assigned expression do not match!");
    }

    @Override
    public String toString() {
        return variableName + " = " + expression.toString();
    }
}
