package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.IntType;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.IntValue;
import com.example.toylanguage6.model.Values.Value;
import javafx.util.Pair;

import java.util.List;
import java.util.Vector;

public class ReleaseSemaphoreStatement implements StatementInterface {
    private String variableName;

    public ReleaseSemaphoreStatement(String variableName) {
        this.variableName = variableName;
    }


    @Override
    public StatementInterface deepCopy() {
        return new ReleaseSemaphoreStatement(this.variableName);
    }

    @Override
    public String toString() {
        return "releaseSemaphore(" + this.variableName + ")";
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        if (!typeEnvironment.isDefined(this.variableName)) {
            throw new InterpreterException("The variable " + this.variableName + " is not defined!");
        }

        if (!typeEnvironment.lookup(this.variableName).equals(new IntType())) {
            throw new InterpreterException("The variable " + this.variableName + " is not of type int!");
        }

        return typeEnvironment;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        try {
            Value variableValue = state.getSymbolTable().lookup(this.variableName);
            if (!variableValue.getType().equals(new IntType())) {
                throw new InterpreterException("The variable " + this.variableName + " is not of type int!");
            }

            int semaphoreLocation = ((IntValue) variableValue).getValue();
            if (!state.getSemaphoreTable().isDefined(semaphoreLocation)) {
                throw new InterpreterException("The semaphore " + this.variableName + " is not defined!");
            }

            synchronized (state.getSemaphoreTable()) {
                Pair<Integer, List<Integer>> semaphoreEntry = state.getSemaphoreTable().lookup(semaphoreLocation);
                int NL = semaphoreEntry.getKey();
                List<Integer> threads = semaphoreEntry.getValue();
                if (threads.contains(state.getId_thread())) {
                    threads.remove(Integer.valueOf(state.getId_thread()));
                }
            }
            return null;

        } catch (InterpreterException e) {
            throw new InterpreterException(e.getMessage());
        }

    }
}
