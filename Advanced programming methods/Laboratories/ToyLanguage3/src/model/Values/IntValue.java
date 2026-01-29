package model.Values;

import model.Types.IntType;
import model.Types.Type;

public class IntValue implements Value {
    private final int value;

    // constructor
    public IntValue(int value){
        this.value = value;
    }

    // getter
    public int getValue(){
        return this.value;
    }

    @Override
    public String toString(){
        //TODO : I do not actually understand this below line
        return Integer.toString(this.value);
        // why not:
        // return IntType.toString() + this.value?
    }

    @Override
    public Type getType(){
        return new IntType();
    }

    @Override
    public Value deepCopy() {
        return new IntValue(value);
    }

    @Override
    public boolean equals(Object object){
        // if they are exactly the same Object
        if(this == object)
            return true;
        if(object instanceof IntValue){
            IntValue comparedIntValue = (IntValue) object;
            return this.value == comparedIntValue.getValue();
        } else
            return false;
    }
}
