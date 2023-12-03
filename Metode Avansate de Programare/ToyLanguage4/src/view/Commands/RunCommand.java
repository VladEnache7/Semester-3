package view.Commands;

import controller.Controller;
import exceptions.InterpreterException;

public class RunCommand extends Command {
    private Controller controller;

    public RunCommand(String key, String description, Controller controller) {
        super(key, description);
        this.controller = controller;
    }

    @Override
    public void execute() throws InterpreterException {
        try {
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
