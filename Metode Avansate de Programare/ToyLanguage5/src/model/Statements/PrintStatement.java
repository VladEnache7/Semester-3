package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyListInterface;
import model.Expressions.Expression;
import model.ProgramState;
import model.Types.Type;
import model.Values.Value;

public class PrintStatement implements StatementInterface {
    private final Expression expression;

    public PrintStatement(Expression expression) {
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyListInterface<Value> output = state.getOutput();
        output.add(expression.evaluate(state.getSymbolTable(), state.getHeap()));
        state.setOutput(output);
        //return state; 
    return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new PrintStatement(expression.deepCopy());
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        expression.typeCheck(typeEnvironment);
        return typeEnvironment;
    }

    @Override
    public String toString(){
        if(expression != null)
            return "print(" + expression.toString() + ")";
        else
            return "print()";
    }
}
