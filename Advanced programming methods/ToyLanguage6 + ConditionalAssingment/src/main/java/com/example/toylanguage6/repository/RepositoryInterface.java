package com.example.toylanguage6.repository;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ProgramState;

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

    void typeCheck() throws InterpreterException;
}
