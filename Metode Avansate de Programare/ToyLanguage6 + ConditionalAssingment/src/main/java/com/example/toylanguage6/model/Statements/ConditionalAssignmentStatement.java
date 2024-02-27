package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.Expressions.Expression;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.Type;

public class ConditionalAssignmentStatement implements StatementInterface {
    private final String variableName;
    private final Expression expression1;
    private final Expression expression2;
    private final Expression expression3;

    public ConditionalAssignmentStatement(String variableName, Expression expression1, Expression expression2, Expression expression3) {
        this.variableName = variableName;
        this.expression1 = expression1;
        this.expression2 = expression2;
        this.expression3 = expression3;
    }

    @Override
    public String toString() {
        return variableName + " = (" + expression1.toString() + ") ? " + expression2.toString() + " : " + expression3.toString();
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        StatementInterface ifStatement = new IfStatement(expression1, new AssignStatement(variableName, expression2), new AssignStatement(variableName, expression3));
        state.getExecutionStack().push(ifStatement);
        return null;
    }

    @Override
    public StatementInterface deepCopy() {
        return new ConditionalAssignmentStatement(variableName, expression1.deepCopy(), expression2.deepCopy(), expression3.deepCopy());
    }

    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        Type variableType = typeEnvironment.lookup(variableName);
        Type expression1Type = expression1.typeCheck(typeEnvironment);
        Type expression2Type = expression2.typeCheck(typeEnvironment);
        Type expression3Type = expression3.typeCheck(typeEnvironment);
        // check if expression1 is boolean
        if(!expression1Type.equals(new com.example.toylanguage6.model.Types.BoolType())){
            throw new InterpreterException("ConditionalAssignmentStatement: The type of the expression 1 is not boolean!");
        }
        // if the type of the variable is the same as expression2 and 3
        if(variableType.equals(expression2Type) && variableType.equals(expression3Type)){
            return typeEnvironment;
        }
        else{
            throw new InterpreterException("ConditionalAssignmentStatement: The types of the expressions 2 & 3 are not same as the variable!");
        }
    }
}
