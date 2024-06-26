package model.Types;

import model.Values.StringValue;
import model.Values.Value;

public class StringType implements Type {
    @Override
    public boolean equals(Object another) {
        return another instanceof StringType;
    }
    @Override
    public String toString() {
        return "string";
    }
    @Override
    public Value getDefault() {
        return new StringValue("Empty String");
    }
    @Override
    public Type deepCopy() {
        return new StringType();
    }
}
