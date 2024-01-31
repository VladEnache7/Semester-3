package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.IntType;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.IntValue;
import javafx.util.Pair;

import java.util.List;

public class AcquireSemaphoreStatement implements StatementInterface {
    private String variableName;

    public AcquireSemaphoreStatement(String variableName) {
        this.variableName = variableName;
    }

    @Override
    public StatementInterface deepCopy() {
        return new AcquireSemaphoreStatement(this.variableName);
    }

    @Override
    public String toString() {
        return "acquireSemaphore(" + this.variableName + ")";
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        if (!typeEnvironment.isDefined(this.variableName)) {
            throw new InterpreterException("AcquireSemaphoreStatement: The variable " + this.variableName + " is not defined!");
        }

        if (!typeEnvironment.lookup(this.variableName).equals(new IntType())) {
            throw new InterpreterException("AcquireSemaphoreStatement: The variable " + this.variableName + " is not of type int!");
        }

        return typeEnvironment;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        try {
            // the check has already been made in the typeCheck method
            int semaphoreLocation = ((IntValue) state.getSymbolTable().lookup(this.variableName)).getValue();

            if (!state.getSemaphoreTable().isDefined(semaphoreLocation)) {
                throw new InterpreterException("AcquireSemaphoreStatement: The semaphore " + this.variableName + " is not defined!");
            }
            synchronized (state.getSemaphoreTable()) {
                Pair<Integer, List<Integer>> semaphore = state.getSemaphoreTable().lookup(semaphoreLocation);

                int NL = semaphore.getKey();
                List<Integer> threads = semaphore.getValue();
                if (NL > threads.size()) { // if the number of threads is smaller than the NL
                    if (!threads.contains(state.getId_thread())) { // if the current thread is not in the list
                        threads.add(state.getId_thread());
                    }
                } else {
                    state.getExecutionStack().push(this);
                }
            }
        } catch (InterpreterException e) {
            throw new InterpreterException("AcquireSemaphoreStatement: " + e.getMessage());
        }
        return null;
    }
}
