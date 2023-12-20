package com.example.toylanguage6.model.Expressions;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.MyDictionaryInterface;
import com.example.toylanguage6.model.ADTs.MyHeapInterface;
import com.example.toylanguage6.model.Expressions.Expression;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Types.RefType;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.RefValue;
import com.example.toylanguage6.model.Values.Value;

public class HeapReadingExpression implements Expression {
    private final Expression expression;

    public HeapReadingExpression(Expression expression) {
        this.expression = expression;
    }
    @Override
    public Value evaluate(MyDictionaryInterface<String, Value> table, MyHeapInterface<Value> heap) throws InterpreterException {
        Value value = expression.evaluate(table, heap);
        if (!(value instanceof RefValue))
            throw new InterpreterException("Expression is not of type RefType!");
        // the expression is evaluated to a RefValue. The address of the RefValue is extracted.
        if(!heap.exists(((RefValue) value).getAddress()))
            throw new InterpreterException("Address does not exist in heap!");
        // the address is used to get the value from the heap. If the address is not a key in the heap, the execution is stopped with an appropriate error message.
        Value valueFromHeap = heap.get(((RefValue) value).getAddress());
        // the value from the heap is returned.
        return valueFromHeap;
    }

    @Override
    public Expression deepCopy() {
        return new HeapReadingExpression(expression.deepCopy());
    }

    @Override
    public Type typeCheck(MyDictionaryInterface<String, Type> typeEnvironment) throws InterpreterException {
        Type type = expression.typeCheck(typeEnvironment);
        if (type instanceof RefType){
            RefType refType = (RefType) type;
            return refType.getInner();
        } else {
            throw new InterpreterException("Expression is not of type RefType!");
        }
    }

    @Override
    public String toString() {
        return "readHeap(" + expression.toString() + ")";
    }
}
