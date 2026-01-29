package com.example.toylanguage6.model.ADTs;
import java.util.Map;
import java.util.HashMap;
import java.util.concurrent.atomic.AtomicInteger;
public class MyHeap<AnyType> implements MyHeapInterface<AnyType> {
    AtomicInteger freeLocation; // An int value that is updated atomically in order to increment it atomically
    Map<Integer, AnyType> heap;

    public MyHeap() {
        this.heap = new HashMap<>();
        this.freeLocation = new AtomicInteger(0);
    }

    @Override
    public int allocate(AnyType value) {
        this.heap.put(this.freeLocation.incrementAndGet(), value);
        return this.freeLocation.get();
    }

    @Override
    public AnyType deallocate(int address) {
        return this.heap.remove(address);
    }

    @Override
    public AnyType get(int address) {
        return this.heap.get(address);
    }

    @Override
    public void put(int address, AnyType value) {
        this.heap.put(address, value);
    }

    @Override
    public boolean exists(int address) {
        return this.heap.containsKey(address);
    }

    @Override
    public Map<Integer, AnyType> getHeap() {
        return this.heap;
    }

    @Override
    public void setHeap(Map<Integer, AnyType> map) {
        this.heap = map;
    }

    @Override
    public String toString() {
        return this.heap.toString();
    }


}
