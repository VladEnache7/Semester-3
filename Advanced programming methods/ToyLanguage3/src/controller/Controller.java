package controller;

import exceptions.InterpreterException;
import model.ADTs.MyHeap;
import model.ADTs.MyHeapInterface;
import model.ADTs.MyStackInterface;
import model.ProgramState;
import model.Statements.StatementInterface;
import model.Values.RefValue;
import model.Values.Value;
import repository.RepositoryInterface;

import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;

public class Controller {
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
        repo.logProgramStateExec(currentProgramState);
        if(this.displayFlag){
            System.out.println(displayState(currentProgramState));
        }
        while(!currentProgramState.getExecutionStack().isEmpty()){
            try {
                oneStep(currentProgramState);
                repo.logProgramStateExec(currentProgramState);
            } catch (Exception e) {
                throw new InterpreterException(e.getMessage());
            }
            if(this.displayFlag)
                System.out.println(displayState(currentProgramState));
            MyHeapInterface<Value> auxiliaryHeap = new MyHeap<>();
            auxiliaryHeap.setHeap(garbageCollector(getAddrFromSymTabke(currentProgramState.getSymbolTable().values(), currentProgramState.getHeap().getHeap()), currentProgramState.getHeap().getHeap()));
            currentProgramState.getHeap().setHeap(auxiliaryHeap.getHeap());
        }
        // if nothing was displayed on the way, it prints it at the end
        if(!this.displayFlag){
            System.out.println(displayState(currentProgramState));
        }
    }

    public void resetProgramStates() throws InterpreterException {
        repo.resetProgramStates();
    }
    Map<Integer, Value> garbageCollector(Set<Integer> symTableAddr, Map<Integer, Value> heap){ // why set as symTableAddr? because the addresses from the symbol table are unique
        return heap.entrySet().stream()
                .filter(e -> symTableAddr.contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }
    Set<Integer> getAddrFromSymTabke(Collection<Value> symbolTableValues, Map<Integer, Value> heap){
        Set<Integer> toReturn = new TreeSet<>();
        symbolTableValues.stream()
                .filter(v -> v instanceof RefValue)
                .forEach(v -> {
                    while (v instanceof RefValue){
                        toReturn.add(((RefValue) v).getAddress());
                        v = heap.get(((RefValue) v).getAddress());
                    }
                });
        return toReturn;
    }
}
