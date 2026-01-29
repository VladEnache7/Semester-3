package repository;

import exceptions.InterpreterException;
import model.ProgramState;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;

public class Repository implements RepositoryInterface {
    private final LinkedList<ProgramState> programStates;
    private String logFilePath;

    // constructor
    public Repository(String logFilePath) throws InterpreterException {
        try{
            // test if filePath is correct else throw exception
            PrintWriter testPath = new PrintWriter(new BufferedWriter(new FileWriter(logFilePath, true)));
        } catch (IOException exception) {
            throw new InterpreterException(exception.getMessage());
        }
        programStates = new LinkedList<ProgramState>();
        this.logFilePath = logFilePath;
    }

    @Override
    public void addProgram(ProgramState program) {
        programStates.add(program);
    }

    @Override
    public ProgramState getCurrentProgram() {
        ProgramState currentProgramState = programStates.get(0);
//        programStates.removeFirst();
        return currentProgramState;
    }

    @Override
    public void logProgramStateExec(ProgramState program) throws InterpreterException {
        PrintWriter logFile;
        try {
            /*
            The buffer makes the writing process more efficient (it writes to the file in chunks, not one character
            at a time)
             */
            logFile = new PrintWriter(new BufferedWriter(new FileWriter(this.logFilePath, true)));
        } catch (IOException exception) {
            throw new InterpreterException(exception.getMessage());
        }
        logFile.println(program.toString());
        /*
        Write the buffered characters to the file, if the stream has saved any characters from the various write()
         */
        logFile.flush();
        if(program.getExecutionStack().isEmpty()) {
            logFile.close();
        }
    }

    public void resetProgramStates() throws InterpreterException {
        // if(programStates.isEmpty())
        //    throw new InterpreterException("Program state list is empty");
        programStates.get(0).resetProgramState();
    }
}
