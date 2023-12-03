package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyStackInterface;
import model.Expressions.Expression;
import model.ProgramState;
import model.Types.BoolType;
import model.Values.BoolValue;
import model.Values.Value;

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
    public String toString() {
        return "if (" + condition.toString() + ") then (" + thenStatement.toString() + ") else (" + elseStatement.toString() + ")";
    }
}
