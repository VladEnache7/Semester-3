package model.Values;

import model.Types.BoolType;
import model.Types.Type;

public class BoolValue implements Value {
    private final boolean value;

    // constructor
    public BoolValue(boolean value) {
        this.value = value;
    }

    // getter
    public boolean getValue(){
        return this.value;
    }

    @Override
    public String toString(){
        //TODO : I do not actually understand this below line
        return Boolean.toString(this.value);
        // TODO why not:
        // return BoolType.toString() + this.value?
    }

    @Override
    public boolean equals(Object object){
        if (this == object)
            return true;
        if (object instanceof BoolValue){
            BoolValue comparedBoolObject = (BoolValue) object;
            return this.value == comparedBoolObject.getValue();
        }
        else
            return false;
    }

    @Override
    public Type getType(){
        /* It returns a new object BoolType() */
        return new BoolType();
    }

    @Override
    public Value deepCopy() {
        return new BoolValue(value);
    }
}
