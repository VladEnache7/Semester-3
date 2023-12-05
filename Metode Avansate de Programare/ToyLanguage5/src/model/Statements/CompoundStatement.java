package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyStackInterface;
import model.ProgramState;
import model.Types.Type;

public class CompoundStatement implements StatementInterface {
    private final StatementInterface first;
    private final StatementInterface second;


    public CompoundStatement(StatementInterface first, StatementInterface second) {
        this.first = first;
        this.second = second;
    }

    @Override
    public String toString(){
        return "(" + this.first.toString() + "; " + this.second.toString() + ")";
    }

    @Override
    public ProgramState execute(ProgramState state){
        MyStackInterface<StatementInterface> stack = state.getExecutionStack();
        // we push the second statement first because is highly likely that is also compound
        stack.push(this.second);
        stack.push(this.first);
        state.setExecutionStack(stack);
        ////return state; 
    return null;
    }

    @Override
    public StatementInterface deepCopy(){
        return new CompoundStatement(first.deepCopy(), second.deepCopy());
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        return second.typeCheck(first.typeCheck(typeEnvironment));
    }
}
