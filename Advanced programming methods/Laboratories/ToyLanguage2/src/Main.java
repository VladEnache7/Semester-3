import controller.Controller;
import exceptions.InterpreterException;
import model.ADTs.MyDictionary;
import model.ADTs.MyList;
import model.ADTs.MyStack;
import model.ProgramState;
import model.Statements.StatementInterface;
import repository.Repository;
import repository.RepositoryInterface;
import view.Commands.ExitCommand;
import view.Commands.RunCommand;
import view.Examples;
import view.TextMenu;
import view.UserInterface;

import javax.swing.plaf.nimbus.State;

public class Main {
    public static void main(String[] args) {
        StatementInterface[] examples = new Examples().exampleList();

        try {
            StatementInterface example1 = examples[0];
            ProgramState programState1 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), example1);
            RepositoryInterface repository1 = new Repository("log1.txt");
            repository1.addProgram(programState1);
            Controller controller1 = new Controller(repository1);

            StatementInterface example2 = examples[1];
            ProgramState programState2 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), example2);
            RepositoryInterface repository2 = new Repository("log2.txt");
            repository2.addProgram(programState2);
            Controller controller2 = new Controller(repository2);

            StatementInterface example3 = examples[2];
            ProgramState programState3 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), example3);
            RepositoryInterface repository3 = new Repository("log3.txt");
            repository3.addProgram(programState3);
            Controller controller3 = new Controller(repository3);

            StatementInterface example4 = examples[3];
            ProgramState programState4 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), example4);
            RepositoryInterface repository4 = new Repository("log4.txt");
            repository4.addProgram(programState4);
            Controller controller4 = new Controller(repository4);

            TextMenu menu = new TextMenu();
            menu.addCommand(new ExitCommand("0", "exit"));
            menu.addCommand(new RunCommand("1", example1.toString(), controller1));
            menu.addCommand(new RunCommand("2", example2.toString(), controller2));
            menu.addCommand(new RunCommand("3", example3.toString(), controller3));
            menu.addCommand(new RunCommand("4", example4.toString(), controller4));

            menu.show();


        } catch (InterpreterException e) {
            System.out.println(e.getMessage());
        }
    }
}