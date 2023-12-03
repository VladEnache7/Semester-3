package model;

import model.ADTs.*;
import model.Statements.StatementInterface;
import model.Values.StringValue;
import model.Values.Value;

import java.io.BufferedReader;

public class ProgramState {
    // the stack that contains the statements to be executed
    private MyStackInterface<StatementInterface> executionStack;

    // the dictionary that links the name of a variable with a value
    private MyDictionaryInterface<String, Value> symbolTable;

    // the list which contains all the outputs that where made during the execution
    private MyListInterface<Value> output;

    // a copy to the original program in order to not lose everything if an execution is thrown
    StatementInterface originalProgram;
    // the dictionary that links the name of a file with a BufferedReader
    MyDictionaryInterface<StringValue, BufferedReader> fileTable;

    // the heap
    MyHeapInterface<Value> heap;

    // constructor
    public ProgramState(MyStackInterface<StatementInterface> executionStack,
                        MyDictionaryInterface<String, Value> symbolTable,
                        MyListInterface<Value> output,
                        MyDictionaryInterface<StringValue, BufferedReader> fileTable,
                        MyHeapInterface<Value> heap,
                        StatementInterface originalProgram) {
        this.executionStack = executionStack;
        this.symbolTable = symbolTable;
        this.output = output;
        this.originalProgram = originalProgram.deepCopy();
        this.fileTable = fileTable;
        this.heap = heap;
        executionStack.push(originalProgram);
    }
    public MyStackInterface<StatementInterface> getExecutionStack() {
        return executionStack;
    }

    public void setExecutionStack(MyStackInterface<StatementInterface> newExecutionStack) {
        this.executionStack = newExecutionStack;
    }

    public MyDictionaryInterface<String, Value> getSymbolTable() {
        return symbolTable;
    }

    public void setSymbolTable(MyDictionaryInterface<String, Value> newSymbolTable) {
        this.symbolTable = newSymbolTable;
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
        String result = "------- Current Program State ------\n";
        result += "executionStack = " + executionStack + "\n";
        result += ", heap = " + heap + "\n";
        result += ", symbolTable = " + symbolTable + "\n";
        result += ", output = " + output + "\n";
        result += ", fileTable = " + fileTable + "\n";
        result += ", originalProgram = " + originalProgram + "\n\n";
        return result;
    }

    public void resetProgramState(){
        this.executionStack = new MyStack<>();
        this.symbolTable = new MyDictionary<>();
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


}
