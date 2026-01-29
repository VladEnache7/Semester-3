package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.Type;

public class NopStatement implements StatementInterface{
    public NopStatement() {}

    @Override
    public ProgramState execute(ProgramState state) {
        //return state; 
    return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new NopStatement();
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "\n";
    }
}