package model.Values;

import model.Types.StringType;
import model.Types.Type;

import java.util.Objects;

public class StringValue implements Value {
    private final String value;
    // constructor
    public StringValue(String value) {
        this.value = value;
    }
    // getter
    public String getValue() {
        return this.value;
    }

    @Override
    public String toString(){
        return this.value;
    }

    @Override
    public Type getType() {
        return new StringType();
    }

    @Override
    public Value deepCopy() {
        return new StringValue(value);
    }

    @Override
    public boolean equals(Object anotherObject){
        if(this == anotherObject)
            return true;
        if(!(anotherObject instanceof StringValue))
            return false;
        StringValue anotherString = (StringValue) anotherObject;
        return Objects.equals(this.value, anotherString.getValue());
    }
}
