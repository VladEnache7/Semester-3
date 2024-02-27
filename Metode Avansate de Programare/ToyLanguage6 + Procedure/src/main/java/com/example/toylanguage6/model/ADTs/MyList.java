package com.example.toylanguage6.model.ADTs;

import com.example.toylanguage6.exceptions.InterpreterException;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

public class MyList<AnyType> implements MyListInterface<AnyType> {
    private LinkedList<AnyType> list;

    public MyList() {
        this.list = new LinkedList<>();
    }

    @Override
    public void add(AnyType value) {
        this.list.add(value);
    }

    @Override
    public AnyType remove(int position) throws InterpreterException {
        try {
            return this.list.remove(position);
        } catch (Exception e) {
            throw new InterpreterException("Invalid position");
        }
    }

    @Override
    public boolean isEmpty() {
        return this.list.isEmpty();
    }

    @Override
    public int size() {
        return this.list.size();
    }

    @Override
    public AnyType get(int position) throws InterpreterException {
        try {
            return this.list.get(position);
        } catch (Exception e) {
            throw new InterpreterException("Invalid position");
        }
    }

    @Override
    public List<AnyType> getList() {
        return this.list;
    }

    @Override
    public String toString() {
        return this.list.toString();
    }

    @Override
    public Iterator<AnyType> iterator() {
        synchronized (this.list) {
            return this.list.iterator();
        }
    }

}
