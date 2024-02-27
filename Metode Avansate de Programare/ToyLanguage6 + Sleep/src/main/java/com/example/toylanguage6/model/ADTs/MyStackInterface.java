package com.example.toylanguage6.model.ADTs;

import com.example.toylanguage6.exceptions.InterpreterException;

public interface MyStackInterface<AnyType> {
    /**
     * Removes the last element from the stack
     * @return the last element from the stack
     * @throws InterpreterException if the stack is empty
     */
    AnyType pop() throws InterpreterException;

    /**
     * Adds a new element to the stack
     */
    void push(AnyType anyType);
    boolean isEmpty();
    int size();
    /**
     * Returns the last element from the stack
     * @throws InterpreterException if the stack is empty
     */
    AnyType top() throws InterpreterException;

    MyStackInterface<AnyType> deepCopy();
}
