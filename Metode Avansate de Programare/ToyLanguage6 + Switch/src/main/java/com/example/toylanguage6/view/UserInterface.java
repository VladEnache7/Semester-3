package com.example.toylanguage6.view;

import com.example.toylanguage6.controller.Controller;
import com.example.toylanguage6.model.ADTs.MyDictionary;
import com.example.toylanguage6.model.ADTs.MyHeap;
import com.example.toylanguage6.model.ADTs.MyList;
import com.example.toylanguage6.model.ADTs.MyStack;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Statements.StatementInterface;
import com.example.toylanguage6.model.Values.StringValue;
import com.example.toylanguage6.model.Values.Value;

import java.io.BufferedReader;
import java.util.Scanner;

public class UserInterface {
    private final Controller controller;
    private StatementInterface[] hardCodedExamples;


    public UserInterface(Controller controller) {
        this.controller = controller;
    }

    public void printMenu(){
        System.out.print("""
                ------------------ MENU ------------------
                1 - See all programs examples
                2 - Choose a program to execute
                x - Exit
                -->""");
    }

    public void displayAvailablePrograms(){
        System.out.print("""
                ------------------ PROGRAMS ------------------
                1 - int v; v=2; Print(v)
                2 - int a; int b; a=2+3*5;b=a+1; Print(b)
                3 - bool a; int v; a=true; (If a Then v=2 Else v=3); Print(v)
                -->""");
    }

    public void loadProgram(StatementInterface statementToBeRun){
        ProgramState programToBeRun = new ProgramState(
                new MyStack<StatementInterface>(),
                new MyDictionary<String, Value>(),
                new MyList<Value>(),
                new MyDictionary<StringValue, BufferedReader>(),
                new MyHeap<Value>(),
                statementToBeRun);
    this.controller.addProgram(programToBeRun);
    }

    public void chooseProgramAndExecute(){
        // Creating a new Scanner object to read input from the keyboard
        Scanner scanner = new Scanner(System.in);
        System.out.println("Choose a program to execute: ");
        displayAvailablePrograms();
        int programNumber = scanner.nextInt();
//        System.out.print("""
//                        Do you want to see all the execution steps? (true/false)
//                        -->""");
//        boolean displayFlag = scanner.nextBoolean();
//        controller.setDisplayFlag(displayFlag);
        switch (programNumber){
            case 1 -> loadProgram(Examples.exampleList()[0]);
            case 2 -> loadProgram(Examples.exampleList()[1]);
            case 3 -> loadProgram(Examples.exampleList()[2]);
            default -> System.out.println("Invalid program number!");
        }
        try{
            controller.allSteps();
        } catch (Exception exception){
            System.out.println(exception.getMessage());
        }
    }

    public void run(){
        System.out.print("<-- Welcome to the Interpreter of the Toy Language -->");
        Scanner scanner = new Scanner(System.in);
        while(true){
            printMenu();
            String command = scanner.nextLine();
            if(command.equals("x")){
                break;
            }
            switch (command){
                case "1" -> displayAvailablePrograms();
                case "2" -> chooseProgramAndExecute();
                default -> System.out.println("Invalid command!");
            }
        }
    }
}
