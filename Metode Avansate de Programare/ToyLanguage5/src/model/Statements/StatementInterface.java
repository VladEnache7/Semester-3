package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ProgramState;
import model.Types.Type;

public interface StatementInterface {
    ProgramState execute(ProgramState state) throws InterpreterException;
    StatementInterface deepCopy();

    MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException;
}
