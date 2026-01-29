package com.example.toylanguage6.view.Commands;

import com.example.toylanguage6.controller.Controller;
import com.example.toylanguage6.exceptions.InterpreterException;

public class RunCommand extends Command {
    private Controller controller;

    public RunCommand(String key, String description, Controller controller) {
        super(key, description);
        this.controller = controller;
    }

    @Override
    public void execute() throws InterpreterException {
        try {
            controller.typeCheck();
            controller.allSteps();
        } catch (Exception exception) {
            System.out.println(exception.getMessage());
        }
        /*I am not sure how to reset the Program States now*/
        /*try {
            controller.resetProgramStates();
        } catch (InterpreterException e) {
            throw new RuntimeException(e);
        }*/
    }
    public void resetProgramStates() throws InterpreterException {
        controller.resetProgramStates();
    }
}
