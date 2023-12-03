package model.Statements;

import model.Values.Value;
import exceptions.InterpreterException;
import model.ADTs.MyListInterface;
import model.Expressions.Expression;
import model.ProgramState;

public class PrintStatement implements StatementInterface {
    private final Expression expression;

    public PrintStatement(Expression expression) {
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyListInterface<Value> output = state.getOutput();
        output.add(expression.evaluate(state.getSymbolTable()));
        state.setOutput(output);
        return state;
    }

    @Override
    public StatementInterface deepCopy() {
        return new PrintStatement(expression.deepCopy());
    }

    @Override
    public String toString(){
        if(expression != null)
            return "print(" + expression.toString() + ")";
        else
            return "print()";
    }
}
