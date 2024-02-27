package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.Type;

public interface StatementInterface {
    ProgramState execute(ProgramState state) throws InterpreterException;
    StatementInterface deepCopy();

    MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException;
}
