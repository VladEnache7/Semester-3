package com.example.toylanguage6.model.ADTs;

import com.example.toylanguage6.exceptions.InterpreterException;
import javafx.util.Pair;

import java.util.List;

public class MySemaphoreTable extends MyDictionary<Integer, Pair<Integer, List<Integer>>> implements MySemaphoreTableInterface {
    private int freeAddress = 1;

    // constructor
    public MySemaphoreTable() {
        super();
    }

    @Override
    public int put(Pair<Integer, List<Integer>> value) throws InterpreterException {
        synchronized (this) {
            this.add(this.freeAddress, value);
            this.freeAddress++;
            return this.freeAddress - 1;
        }
    }
    @Override
    public int getFreeAddress() {
        synchronized (this) {
            return this.freeAddress;
        }
    }
}
