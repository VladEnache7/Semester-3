package com.example.toylanguage6.view.Commands;

import com.example.toylanguage6.exceptions.InterpreterException;

public abstract class Command {
    private String key;
    private String description;
    public Command(String key, String description){
        this.key = key;
        this.description = description;
    }
    public abstract void execute() throws InterpreterException;
    public String getKey(){
        return this.key;
    }
    public String getDescription(){
        return this.description;
    }
}
