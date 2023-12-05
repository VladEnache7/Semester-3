package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyStack;
import model.ADTs.MyStackInterface;
import model.ProgramState;
import model.Types.Type;
import model.Values.Value;

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
//        newExecutionStack.push(forkStatement);
        MyDictionaryInterface<String, Value> newSymbolTable = state.getSymbolTable().deepCopy();
        ProgramState newProgramState = new ProgramState(newExecutionStack, newSymbolTable, state.getOutput(), state.getFileTable(), state.getHeap(), forkStatement);
        return newProgramState;
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
