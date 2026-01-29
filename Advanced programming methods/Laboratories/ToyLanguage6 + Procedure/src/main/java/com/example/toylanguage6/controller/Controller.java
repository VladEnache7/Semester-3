package com.example.toylanguage6.controller;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyHeapInterface;
import com.example.toylanguage6.model.ADTs.MyListInterface;
import com.example.toylanguage6.model.ADTs.MyProcedureTableInterface;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Values.RefValue;
import com.example.toylanguage6.model.Values.StringValue;
import com.example.toylanguage6.model.Values.Value;
import com.example.toylanguage6.repository.RepositoryInterface;

import java.io.BufferedReader;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

public class Controller {
    private final RepositoryInterface repo;
    /* if displayFlag is true, it displays the current state after each execution of a statement */
    boolean displayFlag;
    private ExecutorService executor;

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
     * it displays the ProgramState: the execution stack, the symbol table and the output
     */
    public String displayState(ProgramState state){
        return state.toString();
    }

    public void setDisplayFlag(Boolean flag){
        this.displayFlag = flag;
    }

    public List<ProgramState> removeCompletedPrograms(List<ProgramState> inputProgramList) {
        return inputProgramList.stream()
                .filter(ProgramState::isNotCompleted)
                .collect(Collectors.toList());
    }
    public void garbageCollectorWrapper() throws InterpreterException{
        List<ProgramState> programStateList = repo.getProgramStatesList();
        ProgramState oneState = programStateList.get(0);
        // garbage collector
        oneState.getHeap().setHeap(
                garbageCollector(
                        getAddrFromSymTable(
                                programStateList.stream()
                                        .map(programState -> {
                                            try {
                                                return programState.getSymbolTable().values();
                                            } catch (InterpreterException e) {
                                                System.out.println(e.getMessage());
                                                return null;
                                            }
                                        })
                                        .collect(Collectors.toList()),
                                oneState.getHeap().getHeap()),
                        oneState.getHeap().getHeap()));
    }
    public Map<Integer, Value> garbageCollector(Set<Integer> symTableAddr, Map<Integer, Value> heap){ // why set as symTableAddr? because the addresses from the symbol table are unique
        return heap.entrySet().stream()
                .filter(e -> symTableAddr.contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

    public void allSteps() throws InterpreterException{
        /*Resetting the log file in order to not have past executions of the program*/
        repo.resetLogFile();
        /*Printing the original program state*/
        repo.getProgramStatesList().forEach(programState -> {
            try{
                this.repo.logProgramStateExec(programState);
            } catch (InterpreterException e) {
                System.out.println(e.getMessage());
            }
        });
        this.executor = Executors.newFixedThreadPool(2);
        // remove the completed programs
        List<ProgramState> programStateList = removeCompletedPrograms(repo.getProgramStatesList());
        while(!programStateList.isEmpty()){
            garbageCollectorWrapper();
            oneStepForAllPrograms(programStateList);
            // remove the completed programs
            programStateList = removeCompletedPrograms(repo.getProgramStatesList());
        }
        executor.shutdownNow();
        // HERE the repository still contains at least one Completed Prg
        // and its List<PrgState> is not empty. Note that oneStepForAllPrg calls the method
        // setPrgList of repository in order to change the repository
        // update the repository state
        repo.setProgramStatesList(programStateList);
    }
    public void oneStepForAllPrograms(List<ProgramState> programStateList) throws InterpreterException {

        List<Callable<ProgramState>> callList = programStateList.stream()
                .map((ProgramState programState)->(Callable<ProgramState>)(programState::oneStep))
                .collect(Collectors.toList());

        Collections.shuffle(callList);
        // start the execution of the callables
        // it returns the list of new created PrgStates(namely, threads)
        try {
            List<ProgramState> newProgramList = executor.invokeAll(callList).stream()
                    .map(future -> {
                        try {
                            return future.get();
                        } catch (Exception e) {
                            System.out.println(e.getMessage());
                            return null;
                        }
                    })
                    .filter(p -> p != null)
                    .collect(Collectors.toList());
            if (!newProgramList.isEmpty())
                programStateList.add(newProgramList.get(0));
        } catch (Exception e) {
            throw new InterpreterException(e.getMessage());
        }
        this.repo.setProgramStatesList(programStateList);

        programStateList.stream().forEach(programState -> {
            try{
                this.repo.logProgramStateExec(programState);
            } catch (InterpreterException e) {
                System.out.println(e.getMessage());
            }
        });
        /*If the execution stack is empty, print in the command line how all looks at the end*/
        programStateList.stream()
            .filter(programState -> programState.getExecutionStack().isEmpty())
            .forEach(programState -> {
                try{
                    System.out.println(programState.toString());
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            });

    }
    public void resetProgramStates() throws InterpreterException {
        repo.resetProgramStates();
    }

    Set<Integer> getAddrFromSymTable(List<Collection<Value>> symbolTablesValues, Map<Integer, Value> heap){
        Set<Integer> toReturn = new TreeSet<>();
        symbolTablesValues
                .forEach(symbolTable -> symbolTable.stream()
                .filter(v -> v instanceof RefValue)
                .forEach(v -> {
                    while (v instanceof RefValue){
                        toReturn.add(((RefValue) v).getAddress());
                        v = heap.get(((RefValue) v).getAddress());
                    }
                }));
        return toReturn;
    }

    public void typeCheck() throws InterpreterException {
        repo.typeCheck();
    }

    public List<ProgramState> getProgramStatesList() {
        return repo.getProgramStatesList();
    }

    public MyListInterface<Value> getOutput() { return this.getProgramStatesList().get(0).getOutput();}
    public MyDictionaryInterface<StringValue, BufferedReader> getFileTable() {return this.getProgramStatesList().get(0).getFileTable();}
    public MyHeapInterface<Value> getHeapTable() {return this.getProgramStatesList().get(0).getHeap();}

    public void oneStepForAllProgramsGUI() throws InterpreterException {
        this.executor = Executors.newFixedThreadPool(2);
        List<ProgramState> programStateList = removeCompletedPrograms(repo.getProgramStatesList());
        if(!programStateList.isEmpty()) {
            garbageCollectorWrapper();
            oneStepForAllPrograms(programStateList);
            repo.setProgramStatesList(programStateList);
        }
        else {
            throw new InterpreterException("Controller: Execution has finished. Program state list is empty.");
        }
        executor.shutdown();
    }

    public MyProcedureTableInterface getProcedureTable() {
        return this.getProgramStatesList().get(0).getProcedureTable();
    }
}
