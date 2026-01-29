package com.example.toylanguage6.model;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.*;
import com.example.toylanguage6.model.Statements.StatementInterface;
import com.example.toylanguage6.model.Types.Type;
import com.example.toylanguage6.model.Values.StringValue;
import com.example.toylanguage6.model.Values.Value;
import javafx.util.Pair;

import java.io.BufferedReader;

public class ProgramState {
    // the stack that contains the statements to be executed
    private MyStackInterface<StatementInterface> executionStack;

    // the dictionary that links the name of a variable with a value
    private MyStackInterface<MyDictionaryInterface<String, Value>> symbolTables;

    // the list which contains all the outputs that where made during the execution
    private MyListInterface<Value> output;

    // a copy to the original program in order to not lose everything if an execution is thrown
    StatementInterface originalProgram;
    // the dictionary that links the name of a file with a BufferedReader
    MyDictionaryInterface<StringValue, BufferedReader> fileTable;

    // the heap
    MyHeapInterface<Value> heap;

    // the procedure table
    MyProcedureTableInterface procedureTable;


    // the current id will uniquely instantiate each program state with an unique id
    private static int currentId = 1;
    // the id of the current program state
    private int id;

    public synchronized void setId() {
        this.id = currentId;
        currentId++; // increment the id for the next program state
    }

    // constructor
    public ProgramState(MyStackInterface<StatementInterface> executionStack,
                        MyDictionaryInterface<String, Value> symbolTable,
                        MyListInterface<Value> output,
                        MyDictionaryInterface<StringValue, BufferedReader> fileTable,
                        MyHeapInterface<Value> heap,
                        StatementInterface originalProgram) {
        this.executionStack = executionStack;
        this.symbolTables = new MySymbolTableStack();
        this.symbolTables.push(symbolTable);
        this.output = output;
        this.originalProgram = originalProgram.deepCopy();
        this.fileTable = fileTable;
        this.heap = heap;
        executionStack.push(originalProgram);
        setId();
    }

    public ProgramState(MyStackInterface<StatementInterface> executionStack,
                        MyDictionaryInterface<String, Value> symbolTable,
                        MyListInterface<Value> output,
                        MyDictionaryInterface<StringValue, BufferedReader> fileTable,
                        MyHeapInterface<Value> heap,
                        MyProcedureTableInterface procedureTable,
                        StatementInterface originalProgram) {
        this.executionStack = executionStack;
        this.symbolTables = new MySymbolTableStack();
        this.symbolTables.push(symbolTable);
        this.output = output;
        this.originalProgram = originalProgram.deepCopy();
        this.fileTable = fileTable;
        this.heap = heap;
        this.procedureTable = procedureTable;
        executionStack.push(originalProgram);
        setId();
    }


    public Integer getId_thread() {
        return this.id;
    }

    public boolean isNotCompleted() {
        return !executionStack.isEmpty();
    }

    public ProgramState oneStep() throws InterpreterException {
        if(executionStack.isEmpty())
            throw new InterpreterException("ProgramState: Program state stack is empty");
        StatementInterface currentStatement = executionStack.pop();
        return currentStatement.execute(this);
    }

    public MyStackInterface<StatementInterface> getExecutionStack() {
        return executionStack;
    }

    public void setExecutionStack(MyStackInterface<StatementInterface> newExecutionStack) {
        this.executionStack = newExecutionStack;
    }

    public MyDictionaryInterface<String, Value> getSymbolTable() throws InterpreterException {
        if(symbolTables.isEmpty())
            throw new InterpreterException("ProgramState: Program state symbol table stack is empty");
        return symbolTables.top();
    }

    public MyStackInterface<MyDictionaryInterface<String, Value>> getAllSymbolTables() {
        return symbolTables;
    }

    public void setSymbolTable(MyDictionaryInterface<String, Value> newSymbolTable) {
        // pop the current symbol table and push the new one
        symbolTables.pop();
        symbolTables.push(newSymbolTable);
    }

    public MyListInterface<Value> getOutput() {
        return output;
    }

    public void setOutput(MyListInterface<Value> newOutput) {
        this.output = newOutput;
    }

    public StatementInterface getOriginalProgram() {
        return originalProgram;
    }

    public void setOriginalProgram(StatementInterface newOriginalProgram) {
        this.originalProgram = newOriginalProgram;
    }

    public MyDictionaryInterface<StringValue, BufferedReader> getFileTable() {
        return fileTable;
    }

    public void setFileTable(MyDictionaryInterface<StringValue, BufferedReader> newFileTable) {
        this.fileTable = newFileTable;
    }
    @Override
    public String toString() {
        String result = "------- Program State: ------\n";
        result += "ID = " + id + "\n";
        result += "executionStack = " + executionStack + "\n";
        result += ", heap = " + heap + "\n";
        result += ", symbolTable = " + symbolTables + "\n";
        result += ", output = " + output + "\n";
        result += ", fileTable = " + fileTable + "\n";
        result += ", originalProgram = " + originalProgram + "\n\n";
        return result;
    }

    public void resetProgramState(){
        this.executionStack = new MyStack<>();
        this.symbolTables = new MyStack<>();
        this.output = new MyList<>();
        this.fileTable = new MyDictionary<>();
        this.heap = new MyHeap<>();
        this.executionStack.push(this.originalProgram);
    }

    public MyHeapInterface<Value> getHeap() {
        return this.heap;
    }

    public void setHeap(MyHeapInterface<Value> heap) {
        this.heap = heap;
    }


    public void typeCheck() throws InterpreterException {
        MyDictionaryInterface<String, Type> typeEnvironment = new MyDictionary<>();
        originalProgram.typeCheck(typeEnvironment);
    }

    public MyProcedureTableInterface getProcedureTable() {
        return procedureTable;
    }

    public void setProcedureTable(MyProcedureTableInterface procedureTable) {
        this.procedureTable = procedureTable;
    }
}
