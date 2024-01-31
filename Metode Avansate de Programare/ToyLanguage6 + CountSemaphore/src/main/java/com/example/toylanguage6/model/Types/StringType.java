package com.example.toylanguage6.model.Types;

import com.example.toylanguage6.model.Values.StringValue;
import com.example.toylanguage6.model.Values.Value;

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
