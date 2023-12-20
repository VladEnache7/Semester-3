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

public class WhileStatement implements StatementInterface {
    private final Expression expression;
    private final StatementInterface statement;


    public WhileStatement(Expression expression, StatementInterface statement) {
        this.expression = expression;
        this.statement = statement;
    }

    @Override
    public String toString() {
        return "while(" + this.expression.toString() + ") { " + this.statement.toString() + " }";
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyStackInterface<StatementInterface> executionStack = state.getExecutionStack();

        Value valueOfExpression = this.expression.evaluate(state.getSymbolTable(), state.getHeap());
        if(!(valueOfExpression instanceof BoolValue))
            throw new InterpreterException("Expression not of type bool");

        if(((BoolValue)valueOfExpression).getValue()) { // if the expression is true
            executionStack.push(this.deepCopy());
            executionStack.push(this.statement);
        }

        state.setExecutionStack(executionStack);
        //return state; 
    return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new WhileStatement(this.expression.deepCopy(), this.statement.deepCopy());
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        Type typeExpression = this.expression.typeCheck(typeEnvironment);
        if(typeExpression.equals(new BoolType())) {
            this.statement.typeCheck(typeEnvironment.deepCopy());
            return typeEnvironment;
        }
        else
            throw new InterpreterException("The condition of WHILE is not of type bool");
    }
}
