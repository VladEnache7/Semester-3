package repository;

import exceptions.InterpreterException;
import model.ProgramState;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class Repository implements RepositoryInterface {
    private List<ProgramState> programStatesList;
    private String logFilePath;

    // constructor
    public Repository(String logFilePath) throws InterpreterException {
        try{
            // test if filePath is correct else throw exception
            PrintWriter testPath = new PrintWriter(new BufferedWriter(new FileWriter(logFilePath, true)));
        } catch (IOException exception) {
            throw new InterpreterException(exception.getMessage());
        }
        programStatesList = new ArrayList<ProgramState>();
        this.logFilePath = logFilePath;
    }

    @Override
    public void addProgram(ProgramState program) {
        programStatesList.add(program);
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

    public void resetLogFile() throws InterpreterException {
        PrintWriter logFile;
        try {
            /*
            The buffer makes the writing process more efficient (it writes to the file in chunks, not one character
            at a time)
             */
            logFile = new PrintWriter(new BufferedWriter(new FileWriter(this.logFilePath, false)));
        } catch (IOException exception) {
            throw new InterpreterException(exception.getMessage());
        }
        logFile.println("");
        /*
        Write the buffered characters to the file, if the stream has saved any characters from the various write()
         */
        logFile.flush();
        logFile.close();
    }

    public void resetProgramStates() throws InterpreterException {
         if(programStatesList.isEmpty())
            throw new InterpreterException("Program state list is empty");
        programStatesList.get(0).resetProgramState();
    }

    @Override
    public List<ProgramState> getProgramStatesList() {
        return programStatesList;
    }

    @Override
    public void setProgramStatesList(List<ProgramState> programStatesList) {
        this.programStatesList = programStatesList;
    }

    @Override
    public ProgramState getProgramStateWithId(int currentId) {
        for(ProgramState programState : programStatesList) {
            if(programState.getId_thread() == currentId)
                return programState;
        }
        return null;
    }
}
