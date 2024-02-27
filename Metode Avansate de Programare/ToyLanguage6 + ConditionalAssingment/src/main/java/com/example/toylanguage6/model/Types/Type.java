package com.example.toylanguage6.model.Types;

import com.example.toylanguage6.model.Values.Value;

public interface Type {
    Value getDefault();

    Type deepCopy();
}
