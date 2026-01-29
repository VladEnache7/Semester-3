package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyStack;
import com.example.toylanguage6.model.ADTs.MyStackInterface;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.Value;

public class ForkStatement implements StatementInterface {
    private final StatementInterface forkStatement;

    public ForkStatement(StatementInterface statement) {
        this.forkStatement = statement;
    }

    @Override
    public String toString() {
        return "fork(" + forkStatement.toString() + ")";
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyStackInterface<StatementInterface> newExecutionStack = new MyStack<>();
//        newExecutionStack.push(forkStatement); // I do not push it because it is already pushed in the ProgramState constructor
//        MyStackInterface<MyDictionaryInterface<String, Value>> newSymbolTables = state.getAllSymbolTables().deepCopy();
        return new ProgramState(newExecutionStack, state.getSymbolTable().deepCopy(), state.getOutput(), state.getFileTable(), state.getHeap(), state.getProcedureTable(), forkStatement);
    }

    @Override
    public StatementInterface deepCopy() {
        return new ForkStatement(forkStatement.deepCopy());
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        forkStatement.typeCheck(typeEnvironment.deepCopy());
        return typeEnvironment;
    }
}
