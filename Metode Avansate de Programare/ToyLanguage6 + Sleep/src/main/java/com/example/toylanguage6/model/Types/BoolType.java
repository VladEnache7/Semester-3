package com.example.toylanguage6.model.Types;

import com.example.toylanguage6.model.Values.BoolValue;
import com.example.toylanguage6.model.Values.Value;

public class BoolType implements Type {

    @Override
    public boolean equals(Object another){
        return another instanceof BoolType;
    }

    @Override
    public String toString(){
        return "bool";
    }

    @Override
    public Value getDefault(){
        return new BoolValue(false);
    }

    @Override
    public Type deepCopy() {
        return new BoolType();
    }
}
