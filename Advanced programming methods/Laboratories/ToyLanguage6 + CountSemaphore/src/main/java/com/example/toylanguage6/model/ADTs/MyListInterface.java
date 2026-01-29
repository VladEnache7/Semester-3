package com.example.toylanguage6.model.ADTs;

import com.example.toylanguage6.exceptions.InterpreterException;

import java.util.List;

public interface MyListInterface<AnyType> extends Iterable<AnyType> {
    /**
     * Adds a new element to the list
     */
    void add(AnyType value);

    /**
     * Removes an element from the list
     * @throws InterpreterException if the position is invalid (out of range)
     */
    AnyType remove(int position) throws InterpreterException;
    boolean isEmpty();
    int size();
    AnyType get(int position) throws InterpreterException;
    List<AnyType> getList();

}
