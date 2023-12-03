package repository;

import exceptions.InterpreterException;
import model.ProgramState;
import java.util.LinkedList;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;

public class Repository implements RepositoryInterface {
    private final LinkedList<ProgramState> programStates;
    private String logFilePath;

    // constructor
    public Repository() {
        programStates = new LinkedList<ProgramState>();
    }

    @Override
    public void addProgram(ProgramState program) {
        programStates.add(program);
    }

    @Override
    public ProgramState getCurrentProgram() {
        ProgramState currentProgramState = programStates.get(0);
        programStates.removeFirst();
        return currentProgramState;
    }
}
