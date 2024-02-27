package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.Type;

public class SleepStatement implements StatementInterface {
    private final Integer number;

    public SleepStatement(int number) {
        this.number = number;
    }
    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        if (number == 0)
            return null;
        else
            state.getExecutionStack().push(new SleepStatement(number - 1));
        return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new SleepStatement(this.number);
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        return typeEnvironment;
    }

    @Override
    public String toString(){
        return "sleep(" + number.toString() + ")";
    }
}
