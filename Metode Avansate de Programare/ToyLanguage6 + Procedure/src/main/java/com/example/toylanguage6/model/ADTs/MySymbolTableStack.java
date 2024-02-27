package com.example.toylanguage6.model.ADTs;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.Values.Value;

public class MySymbolTableStack extends MyStack<MyDictionaryInterface<String, Value>> {
    public MySymbolTableStack deepCopy() {
        MySymbolTableStack newSymbolTableStack = new MySymbolTableStack();
        for(MyDictionaryInterface<String, Value> symbolTable : this.getStack()){
            newSymbolTableStack.push(symbolTable.deepCopy());
        }
        return newSymbolTableStack;
    }
}
