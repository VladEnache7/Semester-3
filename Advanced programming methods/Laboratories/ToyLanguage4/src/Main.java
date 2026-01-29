import controller.Controller;
import exceptions.InterpreterException;
import model.ADTs.MyDictionary;
import model.ADTs.MyHeap;
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

public class Main {
    public static void main(String[] args) {
        StatementInterface[] examples = new Examples().exampleList();

        try {
            StatementInterface example1 = examples[0];
            ProgramState programState1 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example1);
            RepositoryInterface repository1 = new Repository("log1.txt");
            repository1.addProgram(programState1);
            Controller controller1 = new Controller(repository1);

            StatementInterface example2 = examples[1];
            ProgramState programState2 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example2);
            RepositoryInterface repository2 = new Repository("log2.txt");
            repository2.addProgram(programState2);
            Controller controller2 = new Controller(repository2);

            StatementInterface example3 = examples[2];
            ProgramState programState3 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example3);
            RepositoryInterface repository3 = new Repository("log3.txt");
            repository3.addProgram(programState3);
            Controller controller3 = new Controller(repository3);

            StatementInterface example4 = examples[3];
            ProgramState programState4 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example4);
            RepositoryInterface repository4 = new Repository("log4.txt");
            repository4.addProgram(programState4);
            Controller controller4 = new Controller(repository4);

            StatementInterface example5 = examples[4];
            ProgramState programState5 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example5);
            RepositoryInterface repository5 = new Repository("log5.txt");
            repository5.addProgram(programState5);
            Controller controller5 = new Controller(repository5);

            StatementInterface example6 = examples[5];
            ProgramState programState6 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example6);
            RepositoryInterface repository6 = new Repository("log6.txt");
            repository6.addProgram(programState6);
            Controller controller6 = new Controller(repository6);

            StatementInterface example7 = examples[6];
            ProgramState programState7 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example7);
            RepositoryInterface repository7 = new Repository("log7.txt");
            repository7.addProgram(programState7);
            Controller controller7 = new Controller(repository7);

            StatementInterface example8 = examples[7];
            ProgramState programState8 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example8);
            RepositoryInterface repository8 = new Repository("log8.txt");
            repository8.addProgram(programState8);
            Controller controller8 = new Controller(repository8);

            StatementInterface example9 = examples[8];
            ProgramState programState9 = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), example9);
            RepositoryInterface repository9 = new Repository("log9.txt");
            repository9.addProgram(programState9);
            Controller controller9 = new Controller(repository9);

            
            TextMenu menu = new TextMenu();
            menu.addCommand(new ExitCommand("0", "exit"));
            menu.addCommand(new RunCommand("1", example1.toString(), controller1));
            menu.addCommand(new RunCommand("2", example2.toString(), controller2));
            menu.addCommand(new RunCommand("3", example3.toString(), controller3));
            menu.addCommand(new RunCommand("4", example4.toString(), controller4));
            menu.addCommand(new RunCommand("5", example5.toString(), controller5));
            menu.addCommand(new RunCommand("6", example6.toString(), controller6));
            menu.addCommand(new RunCommand("7", example7.toString(), controller7));
            menu.addCommand(new RunCommand("8", example8.toString(), controller8));
            menu.addCommand(new RunCommand("9", example9.toString(), controller9));


            menu.show();


        } catch (InterpreterException e) {
            System.out.println(e.getMessage());
        }
    }
}