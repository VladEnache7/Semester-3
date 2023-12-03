package controller;

import exceptions.InterpreterException;
import model.ADTs.MyStackInterface;
import model.ProgramState;
import model.Statements.StatementInterface;
import repository.RepositoryInterface;

import javax.swing.plaf.nimbus.State;

public class Controller {
    /* I do not know if it corrects to make repo final */
    private final RepositoryInterface repo;
    /* if displayFlag is true, it displays the current state after each execution of a statement */
    boolean displayFlag;

    // constructor of Controller
    public Controller(RepositoryInterface repo){
        this.repo = repo;
        this.displayFlag = false;
    }

    // adding a program state to the repository (For the future multithreading)
    public void addProgram(ProgramState state) {
        this.repo.addProgram(state);
    }

    /**
     * it executes the last statement from the execution stack
     * @param state the current program state
     * @return the program state after the execution of the last statement from the stack
     * @throws InterpreterException if the execution stack is empty
     */
    public ProgramState oneStep(ProgramState state) throws InterpreterException {

        MyStackInterface<StatementInterface> stack = state.getExecutionStack();
        if(stack.isEmpty()){ // throws an error if execution stack is empty -> there is nothing more to execute
            throw new InterpreterException("Program state is empty!");
        }
        // getting the last statement
        StatementInterface currentStatement = stack.pop();
        // returning the program state after the execution of the last statement from the stack
        return currentStatement.execute(state);
    }

    /**
     * it displays the ProgramState: the execution stack, the symbol table and the output
     */
    public String displayState(ProgramState state){
        return state.toString();
    }

    public void setDisplayFlag(Boolean flag){
        this.displayFlag = flag;
    }

    /**
     * it simply runs oneStep() while the execution stack of the current program is not empty
     * @throws InterpreterException if the execution stack is empty
     */
    public void allSteps() throws InterpreterException {
        ProgramState currentProgramState = repo.getCurrentProgram();
        System.out.println(displayState(currentProgramState));
        if(this.displayFlag){
            System.out.println(displayState(currentProgramState));
        }
        while(!currentProgramState.getExecutionStack().isEmpty()){
            try {
                oneStep(currentProgramState);
            } catch (Exception e) {
                throw new InterpreterException(e.getMessage());
            }
            if(this.displayFlag)
                System.out.println(displayState(currentProgramState));
        }
        // if nothing was displayed on the way, it prints it at the end
        if(!this.displayFlag){
            System.out.println(displayState(currentProgramState));
        }
    }
}
