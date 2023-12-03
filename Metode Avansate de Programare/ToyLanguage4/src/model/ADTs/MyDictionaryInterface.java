package model.ADTs;

import exceptions.InterpreterException;

import java.util.Collection;

public interface MyDictionaryInterface<AnyTypeKey, AnyTypeValue> {
    /**
     * Adds a new pair (key, value) to the dictionary.
     * @throws InterpreterException if the value is null
     */
    void add(AnyTypeKey key, AnyTypeValue value) throws InterpreterException;

    /**
     * Removes a key from the dictionary.
     * @return the value of that key before removal
     * @throws InterpreterException if the key does not exist
     */
    AnyTypeValue remove(AnyTypeKey key) throws InterpreterException;

    /**
     * Updates a key with a new value.
     * @throws InterpreterException if the key does not exist
     */
    void update(AnyTypeKey key, AnyTypeValue newValue) throws InterpreterException;

    /**
     * It returns the value of a key
     * @return the value of a key
     * @throws InterpreterException if the key does not exist
     */
    AnyTypeValue lookup(AnyTypeKey key) throws InterpreterException;
    boolean isEmpty();
    /**
     * Checks if the key is part of the dictionary
     */
    boolean isDefined(AnyTypeKey key);

    /**
     * @return all the values from the dictionary
     */
    Collection<AnyTypeValue> values();


    MyDictionaryInterface<AnyTypeKey,AnyTypeValue> deepCopy();
}
