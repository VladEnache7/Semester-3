package com.example.toylanguage6.model.ADTs;

import com.example.toylanguage6.exceptions.InterpreterException;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class MyDictionary<AnyTypeKey, AnyTypeValue> implements MyDictionaryInterface<AnyTypeKey, AnyTypeValue> {
    private Map<AnyTypeKey, AnyTypeValue> map;
    public MyDictionary(){
        this.map = new HashMap<>();
    }

    @Override
    public void add(AnyTypeKey key, AnyTypeValue value) throws InterpreterException {
        try {
            this.map.put(key, value);
        } catch (Exception e){
            throw new InterpreterException("Null values cannot be added to the dictionary!");
        }
    }

    @Override
    public AnyTypeValue remove(AnyTypeKey key) throws InterpreterException {
        try {
            return this.map.remove(key);
        } catch (Exception e){
            throw new InterpreterException("The key does not exist in the dictionary!");
        }
    }

    @Override
    public void update(AnyTypeKey key, AnyTypeValue newValue) throws InterpreterException {
        try {
            this.map.replace(key, newValue);
        } catch (Exception e) {
            throw new InterpreterException("The key does not exist in the dictionary!");
        }
    }

    @Override
    public AnyTypeValue lookup(AnyTypeKey key) throws InterpreterException {
        try {
            return this.map.get(key);
        } catch (Exception e) {
            throw new InterpreterException("The key does not exist in the dictionary!");
        }
    }

    @Override
    public boolean isEmpty(){
        return this.map.isEmpty();
    }

    @Override
    public boolean isDefined(AnyTypeKey key){
        return this.map.containsKey(key);
    }

    @Override
    public Collection<AnyTypeValue> values(){
        return this.map.values();
    }

    @Override
    public String toString() {
        String result = "{";
        for(AnyTypeKey key : this.map.keySet()){
            result += key.toString() + " = " + this.map.get(key).toString() + ", ";
        }
        if(result.length() > 1)
            result = result.substring(0, result.length() - 2);
        result += "}";
        return result;
    }
    // deepCopy
    public MyDictionaryInterface<AnyTypeKey, AnyTypeValue> deepCopy() throws InterpreterException {
        MyDictionaryInterface<AnyTypeKey, AnyTypeValue> newDictionary = new MyDictionary<>();
        for(AnyTypeKey key : this.map.keySet()){
            newDictionary.add(key, this.map.get(key));
        }
        return newDictionary;
    }

    @Override
    public Map<AnyTypeKey, AnyTypeValue> getContent(){
        return this.map;
    }
}
