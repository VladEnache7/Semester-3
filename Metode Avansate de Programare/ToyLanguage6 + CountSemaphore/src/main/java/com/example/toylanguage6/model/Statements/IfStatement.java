package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyStackInterface;
import com.example.toylanguage6.model.Expressions.Expression;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.BoolType;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.BoolValue;
import com.example.toylanguage6.model.Values.Value;

public class IfStatement implements StatementInterface {
    private final Expression condition;
    private final StatementInterface thenStatement;
    private final StatementInterface elseStatement;

    public IfStatement(Expression condition, StatementInterface thenStatement, StatementInterface elseStatement) {
        this.condition = condition;
        this.thenStatement = thenStatement;
        this.elseStatement = elseStatement;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyDictionaryInterface<String, Value> symbolTable = state.getSymbolTable();
        MyStackInterface<StatementInterface> executionStack = state.getExecutionStack();
        Value conditionValue = condition.evaluate(symbolTable, state.getHeap());
        if (conditionValue.getType().equals(new BoolType())) {
            // if the condition is true it puts to the stack the thenStatement
            if (conditionValue.equals(new BoolValue(true)))
                executionStack.push(thenStatement);
            else // else it puts to the stack the elseStatement
                executionStack.push(elseStatement);
        } else
            throw new InterpreterException("Condition expression is not of type BoolType!");
        state.setExecutionStack(executionStack);
        //return state; 
return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new IfStatement(condition.deepCopy(), thenStatement.deepCopy(), elseStatement.deepCopy());
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        Type typeCondition = condition.typeCheck(typeEnvironment);
        if (typeCondition.equals(new BoolType())) {
            thenStatement.typeCheck(typeEnvironment.deepCopy());
            elseStatement.typeCheck(typeEnvironment.deepCopy());
            return typeEnvironment;
        } else
            throw new InterpreterException("Condition expression is not of type BoolType!");
    }

    @Override
    public String toString() {
        return "if (" + condition.toString() + ") then (" + thenStatement.toString() + ") else (" + elseStatement.toString() + ")";
    }
}
