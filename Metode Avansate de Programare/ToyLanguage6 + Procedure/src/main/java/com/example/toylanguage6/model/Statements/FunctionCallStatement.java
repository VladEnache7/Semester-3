package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyList;
import com.example.toylanguage6.model.Expressions.Expression;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.Value;
import javafx.util.Pair;

import java.util.List;
import java.util.Vector;

public class FunctionCallStatement implements StatementInterface {
    private String functionName;
    private List<Expression> parameters;

    // constructor
    public FunctionCallStatement(String functionName, List<Expression> parameters) {
        this.functionName = functionName;
        this.parameters = new Vector<>();
        this.parameters.addAll(parameters);
    }
    @Override
    public String toString() {
        // have the parameters with , between them
        StringBuilder parametersString = new StringBuilder();
        for (Expression parameter : parameters) {
            parametersString.append(parameter.toString()).append(", ");
        }
        // remove the last ", "
        parametersString.delete(parametersString.length() - 2, parametersString.length());
        return functionName + "(" + parametersString + ")";
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        try {
            // get the function from the procedure table
            Pair<List<String>, StatementInterface> function = state.getProcedureTable().lookup(functionName);

            List<String> parametersNames = function.getKey();
            StatementInterface functionBody = function.getValue();

            // evaluate the parameters and save the values to a list
            List<Value> parametersValues = new Vector<>();
            for (Expression parameter : parameters) {
                parametersValues.add(parameter.evaluate(state.getSymbolTable(), state.getHeap()));
            }

            // create a new symbol table for the function
            MyDictionaryInterface<String, Value> newSymbolTable = state.getSymbolTable().deepCopy();
            // add the parameters to the symbol table
            for (int i = 0; i < parametersNames.size(); i++) {
                newSymbolTable.add(parametersNames.get(i), parametersValues.get(i));
            }

            // push the new symbol table to the symbol table stack
            state.getAllSymbolTables().push(newSymbolTable);

            // push the function body to the execution stack after the return statement
            state.getExecutionStack().push(new FunctionReturnStatement());
            state.getExecutionStack().push(functionBody);
        } catch (InterpreterException e) {
            throw new InterpreterException("FunctionCallStatement: Function " + functionName + " does not exist");
        }
        return null;
    }

    @Override
    public StatementInterface deepCopy() {
        List<Expression> newParameters = new Vector<>();
        for (Expression parameter : parameters) {
            newParameters.add(parameter.deepCopy());
        }
        return new FunctionCallStatement(functionName, newParameters);
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        return typeEnvironment;
    }
}
