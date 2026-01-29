package repository;

import exceptions.InterpreterException;
import model.ProgramState;

import java.util.List;

public interface RepositoryInterface {
//    ProgramState getCurrentProgram();
    void addProgram(ProgramState program);

    void logProgramStateExec(ProgramState programState) throws InterpreterException;

    public void resetProgramStates() throws InterpreterException;

    List<ProgramState> getProgramStatesList();

    void setProgramStatesList(List<ProgramState> programStatesList);

    ProgramState getProgramStateWithId(int currentId);

    void resetLogFile() throws InterpreterException;
}
