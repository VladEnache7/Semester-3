import controller.Controller;
import repository.Repository;
import repository.RepositoryInterface;
import view.UserInterface;

public class Main {
    public static void main(String[] args) {
        RepositoryInterface repository = new Repository();
        Controller controller = new Controller(repository);
        UserInterface userInterface = new UserInterface(controller);
        userInterface.run();
    }
}