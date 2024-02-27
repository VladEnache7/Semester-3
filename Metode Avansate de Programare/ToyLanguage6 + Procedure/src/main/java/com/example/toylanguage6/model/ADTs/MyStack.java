package com.example.toylanguage6.model.ADTs;

import com.example.toylanguage6.exceptions.InterpreterException;

import java.util.Stack;

public class MyStack<AnyType> implements MyStackInterface<AnyType> {
    private Stack<AnyType> stack;

    // constructor
    public MyStack(){
        this.stack = new Stack<AnyType>();
    }

    @Override
    public AnyType pop() {
        try {
            return this.stack.pop();
        } catch (Exception e){
//            throw new InterpreterException("Stack is empty");
            System.out.println("Stack is empty");
            return null;
        }
    }

    @Override
    public AnyType top() {
        try {
            return this.stack.peek();
        } catch (Exception e) {
//            throw new InterpreterException("Stack is empty");
            System.out.println("Stack is empty");
            return null;
        }
    }

    @Override
    public void push(AnyType val){
        this.stack.push(val);
    }

    @Override
    public boolean isEmpty(){
        return stack.isEmpty();
    }

    @Override
    public int size(){
        return stack.size();
    }

    @Override
    public String toString(){
        String result = "\n";
        for(int i = stack.size() - 1; i >= 0; i--){
            result += "| " + stack.get(i).toString() +" |";
            if(i != 0)
                result += "\n";
        }
        return result;
    }

    @Override
    public MyStackInterface<AnyType> deepCopy()  {
        MyStackInterface<AnyType> newStack = new MyStack<AnyType>();
        for(AnyType elem : this.stack){
            newStack.push(elem);
        }
        return newStack;
    }

    public Stack<AnyType> getStack() {
        return stack;
    }
}
