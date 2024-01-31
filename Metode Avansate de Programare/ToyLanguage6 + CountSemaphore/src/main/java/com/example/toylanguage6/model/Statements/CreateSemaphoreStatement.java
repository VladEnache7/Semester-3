package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.Expressions.Expression;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.IntType;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.IntValue;
import com.example.toylanguage6.model.Values.Value;
import javafx.util.Pair;

import java.util.Vector;

public class CreateSemaphoreStatement implements StatementInterface {
    private String variableName;
    private Expression expression;

    public CreateSemaphoreStatement(String variableName, Expression expression) {
        this.variableName = variableName;
        this.expression = expression;
    }


    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        try{
            Value expressionValue = this.expression.evaluate(state.getSymbolTable(), state.getHeap());
            if(!expressionValue.getType().equals(new IntType()))
                throw new InterpreterException("The expression " + expression.toString() + " is not of type int!");
            int expressionInt = ((IntValue) expressionValue).getValue();

            synchronized (state.getSemaphoreTable()){
                int newFreeLocation = state.getSemaphoreTable().put(new Pair<>(expressionInt, new Vector<>())); // Vector is synchronized
                state.getSymbolTable().add(this.variableName, new IntValue(newFreeLocation));
            }
        } catch (InterpreterException e){
            throw new InterpreterException(e.getMessage());
        }
        return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new CreateSemaphoreStatement(this.variableName, this.expression.deepCopy());
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        if(!this.expression.typeCheck(typeEnvironment).equals(new IntType()))
            throw new InterpreterException("The expression " + this.expression.toString() + " is not of type int!");

        if (!typeEnvironment.isDefined( this.variableName))
            throw new InterpreterException("The variable " + this.variableName + " is not declared!");

        if(!typeEnvironment.lookup(this.variableName).equals(new IntType()))
            throw new InterpreterException("The variable " + this.variableName + " is not of type int!");
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "createSemaphore(" + this.variableName + ", " + this.expression.toString() + ")";
    }
}
