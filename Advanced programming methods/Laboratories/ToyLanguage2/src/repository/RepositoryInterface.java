package repository;

import exceptions.InterpreterException;
import model.ProgramState;

public interface RepositoryInterface {
    ProgramState getCurrentProgram();
    void addProgram(ProgramState program);

    void logProgramStateExec(ProgramState program) throws InterpreterException;

    public void resetProgramStates() throws InterpreterException;
}
