package com.example.toylanguage6.view;

import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.view.Commands.Command;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class TextMenu {
    private final Map<String, Command> commands;
//    private final Map<String, Boolean> executedCommands;

    public TextMenu() {
        this.commands = new HashMap<>();
//        this.executedCommands = new HashMap<>();
    }

    public void addCommand(Command c) {
        this.commands.put(c.getKey(), c);
    }

    private void printMenu() {
        System.out.println(" \n----- INTERPRETER COMMANDS ----- ");
        for(Command com: commands.values()) {
            String line = String.format("%4s: %s", com.getKey(), com.getDescription());
            System.out.println(line);
        }
    }

    public void show() throws InterpreterException {
        Scanner scanner = new Scanner(System.in);
        while(true){
            printMenu();
            System.out.println("Input the option: ");
            String key = scanner.nextLine();
            Command command = commands.get(key);
            if(command == null){
                System.out.println("Invalid Option");
                continue;
            }
            /*if(executedCommands.get(key) != null && executedCommands.get(key)){
                RunCommand runCommand = (RunCommand) commands.get(key);
                runCommand.resetProgramStates();
            }*/
            command.execute();
//            executedCommands.put(key, true);
        }
    }
}
