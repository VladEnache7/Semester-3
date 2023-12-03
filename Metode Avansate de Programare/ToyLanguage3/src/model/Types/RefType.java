package model.Types;

import model.Values.RefValue;
import model.Values.Value;

public class RefType implements Type {
    private final Type inner;

    public RefType(Type inner) {
        this.inner = inner;
    }

    @Override
    public Value getDefault() {
        return new RefValue(0, this.inner); // null pointer -> pointer to an invalid address
    }

    @Override
    public Type deepCopy() {
        return new RefType(this.inner);
    }

    public Type getInner() {
        return this.inner;
    }

    @Override
    public boolean equals(Object another){
        if(another instanceof RefType){
            RefType anotherRefType = (RefType) another;
            return this.inner.equals(anotherRefType.getInner());
        } else
            return false;
    }
    @Override
    public String toString() {
        return "Ref("+ this.inner.toString() + ")";
    }
}
