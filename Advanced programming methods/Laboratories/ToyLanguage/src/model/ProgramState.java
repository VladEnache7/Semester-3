package model;

import model.Values.Value;
import model.ADTs.MyDictionaryInterface;
import model.ADTs.MyListInterface;
import model.ADTs.MyStackInterface;
import model.Statements.StatementInterface;

public class ProgramState {
    // the stack that contains the statements to be executed
    private MyStackInterface<StatementInterface> executionStack;

    // the dictionary that links the name of a variable with a value
    private MyDictionaryInterface<String, Value> symbolTable;

    // the list which contains all the outputs that where made during the execution
    private MyListInterface<Value> output;

    // a copy to the original program in order to not lose everything if an execution is thrown
    StatementInterface originalProgram;

    // constructor
    public ProgramState(MyStackInterface<StatementInterface> executionStack,
                        MyDictionaryInterface<String, Value> symbolTable,
                        MyListInterface<Value> output,
                        StatementInterface originalProgram) {
        this.executionStack = executionStack;
        this.symbolTable = symbolTable;
        this.output = output;
        this.originalProgram = originalProgram.deepCopy();
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

    @Override
    public String toString() {
        String result = "------- Current Program State ------\n";
        result += "executionStack = " + executionStack + "\n";
        result += ", symbolTable = " + symbolTable + "\n";
        result += ", output = " + output + "\n";
        result += ", originalProgram = " + originalProgram + "\n\n";
        return result;
    }
}
