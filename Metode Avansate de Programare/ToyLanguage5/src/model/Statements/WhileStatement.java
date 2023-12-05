package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyStackInterface;
import model.Expressions.Expression;
import model.ProgramState;
import model.Types.BoolType;
import model.Types.Type;
import model.Values.BoolValue;
import model.Values.Value;

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
