package com.example.toylanguage6.view.Commands;

public class ExitCommand extends Command {
    public ExitCommand(String key, String description){
        super(key, description);
    }
    @Override
    public void execute() {
        System.exit(0);
    }
}

