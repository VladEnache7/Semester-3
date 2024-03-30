package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.Type;

public class FunctionReturnStatement implements StatementInterface {
    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        try {
            state.getAllSymbolTables().pop();
        } catch (Exception e) {
            throw new InterpreterException("The execution stack is empty!");
        }
        return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new FunctionReturnStatement();
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "return";
    }
}
