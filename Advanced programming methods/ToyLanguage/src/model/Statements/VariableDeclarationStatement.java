package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.ProgramState;
import model.Values.Value;
import model.Types.Type;

public class VariableDeclarationStatement implements StatementInterface{
    private final String name;
    private final Type type;

    public VariableDeclarationStatement(String name, Type type) {
        this.name = name;
        this.type = type;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyDictionaryInterface<String, Value> symbolTable = state.getSymbolTable();
        if(symbolTable.isDefined(name))
            throw new InterpreterException("Variable is already declared");
        else{
            symbolTable.add(name, type.getDefault());
        }
        state.setSymbolTable(symbolTable);
        return state;
    }

    @Override
    public StatementInterface deepCopy() {
        return new VariableDeclarationStatement(name, type);
    }

    @Override
    public String toString() {
        return type.toString() + " " + name;
    }
}