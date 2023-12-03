package model.Statements;

import exceptions.InterpreterException;
import model.ADTs.MyDictionaryInterface;
import model.Expressions.Expression;
import model.ProgramState;
import model.Types.Type;
import model.Values.Value;

public class AssignStatement implements StatementInterface {
    private final String variableName;
    private final Expression expression;

    public AssignStatement(String variableName, Expression expression) {
        this.variableName = variableName;
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyDictionaryInterface<String, Value> symbolTable = state.getSymbolTable();

        if (symbolTable.isDefined(variableName)){
            Value value = expression.evaluate(symbolTable, state.getHeap());
            Type typeVariable = (symbolTable.lookup(variableName)).getType();
            if (value.getType().equals(typeVariable))
                symbolTable.update(variableName, value);
            else
                throw new InterpreterException("Declared type of variable " + variableName + " and type of the assigned expression do not match!");

        } else
            throw new InterpreterException("Variable " + variableName + " is not defined!");
        state.setSymbolTable(symbolTable);
        return state;
    }

    @Override
    public StatementInterface deepCopy() {
        return new AssignStatement(variableName, expression.deepCopy());
    }

    @Override
    public String toString() {
        return variableName + " = " + expression.toString();
    }
}
