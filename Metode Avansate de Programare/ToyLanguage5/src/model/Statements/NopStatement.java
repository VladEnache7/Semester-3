package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ProgramState;
import model.Types.Type;

public class NopStatement implements StatementInterface{
    public NopStatement() {}

    @Override
    public ProgramState execute(ProgramState state) {
        //return state; 
    return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new NopStatement();
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "\n";
    }
}