package model.Statements;

import exceptions.InterpreterException;
import model.ProgramState;

public interface StatementInterface {
    ProgramState execute(ProgramState state) throws InterpreterException;
    StatementInterface deepCopy();
}
