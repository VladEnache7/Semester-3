package model.Statements;

import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyStack;
import model.ADTs.MyStackInterface;
import model.ProgramState;
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
    public ProgramState execute(ProgramState state) {
        MyStackInterface<StatementInterface> newExecutionStack = new MyStack<>();
        newExecutionStack.push(forkStatement);
        MyDictionaryInterface<String, Value> newSymbolTable = state.getSymbolTable().deepCopy();
        return new ProgramState(newExecutionStack, newSymbolTable, state.getOutput(), state.getFileTable(), state.getHeap(), forkStatement);
    }

    @Override
    public StatementInterface deepCopy() {
        return new ForkStatement(forkStatement.deepCopy());
    }
}
