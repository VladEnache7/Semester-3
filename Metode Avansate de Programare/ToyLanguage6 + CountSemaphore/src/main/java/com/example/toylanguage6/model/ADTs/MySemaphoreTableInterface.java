package com.example.toylanguage6.model.ADTs;

import javafx.util.Pair;
import com.example.toylanguage6.exceptions.InterpreterException;

import java.util.List;

public interface MySemaphoreTableInterface extends MyDictionaryInterface<Integer, Pair<Integer, List<Integer>>>{
    int put(Pair<Integer, List<Integer>> value) throws InterpreterException;
    int getFreeAddress();
}
