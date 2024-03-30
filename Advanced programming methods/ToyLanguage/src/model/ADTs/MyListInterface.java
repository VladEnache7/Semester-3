package model.ADTs;

import exceptions.InterpreterException;

import java.util.List;
import java.util.function.Consumer;

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
