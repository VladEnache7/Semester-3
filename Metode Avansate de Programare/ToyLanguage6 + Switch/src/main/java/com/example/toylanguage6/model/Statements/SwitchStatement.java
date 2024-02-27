package com.example.toylanguage6.model.Statements;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyStackInterface;
import com.example.toylanguage6.model.Expressions.Expression;
import com.example.toylanguage6.model.Expressions.RelationalExpression;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.Type;

public class SwitchStatement implements StatementInterface {
    private final Expression expression;
    private final Expression expression1;
    private final StatementInterface statement1;
    private final Expression expression2;
    private final StatementInterface statement2;
    private final StatementInterface statement3;

    public SwitchStatement(Expression expression, Expression expression1, StatementInterface statement1, Expression expression2, StatementInterface statement2, StatementInterface statement3) {
        this.expression = expression;
        this.expression1 = expression1;
        this.statement1 = statement1;
        this.expression2 = expression2;
        this.statement2 = statement2;
        this.statement3 = statement3;
    }

    @Override
    public ProgramState execute(ProgramState state) throws InterpreterException {
        MyStackInterface<StatementInterface> executionStack = state.getExecutionStack();
        StatementInterface newStatement = new IfStatement(
                new RelationalExpression("==", this.expression, this.expression1),
                this.statement1,
                new IfStatement(new RelationalExpression("==", this.expression, this.expression2),
                        this.statement2,
                        this.statement3));
        executionStack.push(newStatement);
        state.setExecutionStack(executionStack);
        return null;
    }



    @Override
    public MyDictionaryInterface<String, Type> typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        // verifing if expression, case1 and case2 are of the same type
        Type typeExpression = this.expression.typeCheck(typeEnvironment);
        Type typeCase1 = this.expression1.typeCheck(typeEnvironment);
        Type typeCase2 = this.expression2.typeCheck(typeEnvironment);

        if (typeExpression.equals(typeCase1) && typeExpression.equals(typeCase2)) {
            // typechecking statement1, statement2 and statement3
            this.statement1.typeCheck(typeEnvironment.deepCopy());
            this.statement2.typeCheck(typeEnvironment.deepCopy());
            this.statement3.typeCheck(typeEnvironment.deepCopy());
            return typeEnvironment;
        } else
            throw new InterpreterException("SwitchStatement: Expression, case1 and case2 are not of the same type!");
    }

    @Override
    public StatementInterface deepCopy() {
        return new SwitchStatement(this.expression.deepCopy(), this.expression1.deepCopy(), this.statement1.deepCopy(), this.expression2.deepCopy(), this.statement2.deepCopy(), this.statement3.deepCopy());
    }

    @Override
    public String toString() {
        return "switch(" + this.expression.toString() + ") (case " + this.expression1.toString() + ": " + this.statement1.toString() + ") (case " + this.expression2.toString() + ": " + this.statement2.toString() + ") (default: " + this.statement3.toString() + ")";
    }
}
