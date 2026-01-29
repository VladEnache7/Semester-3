package model.ADTs;

import java.util.Map;

public interface MyHeapInterface<AnyType> {
    public int allocate(AnyType value); // allocate a new memory location for the given value
    public AnyType deallocate(int address); // deallocate the memory location with the given address

    public AnyType get(int address); // get the value stored at the given address
    public void put(int address, AnyType value); // put the given value at the given address
    public boolean exists(int address); // check if the given address exists in the heap
    public Map<Integer, AnyType> getHeap();
    public void setHeap(Map<Integer, AnyType> map);
}
