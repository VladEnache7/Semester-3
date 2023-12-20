package com.example.toylanguage6.model.Values;

import com.example.toylanguage6.model.Types.Type;

public interface Value {
    Type getType();

    Value deepCopy();
}
