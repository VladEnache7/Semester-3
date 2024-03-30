package com.example.toylanguage6.model.Types;

import com.example.toylanguage6.model.Values.IntValue;
import com.example.toylanguage6.model.Values.Value;

public class IntType implements Type {
    @Override
    public boolean equals(Object another) {
        return another instanceof IntType;
    }

    @Override
    public String toString(){
        return "int";
    }

    @Override
    public Value getDefault(){
        return new IntValue(0);
    }

    @Override
    public Type deepCopy() {
        return new IntType();
    }
}
