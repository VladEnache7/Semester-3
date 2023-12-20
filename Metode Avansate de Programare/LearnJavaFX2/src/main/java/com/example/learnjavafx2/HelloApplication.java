package com.example.learnjavafx2;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

import java.io.IOException;

public class HelloApplication extends Application {
    /**
 * The main entry point for all JavaFX applications.
 * The start method is called after the init method has returned,
 * and after the system is ready for the application to begin running.
 *
 * @param args the command line arguments. JavaFX's applications should launch via the launch method, not by calling main directly.
 */
public static void main(String[] args) {
    // Launches the JavaFX application. This method does not return until the application has exited.
    // This method must be called on the JavaFX launcher thread.
    launch(args);
}

    @Override
    public void start(Stage stage) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(HelloApplication.class.getResource("hello-view.fxml"));
        Scene scene = new Scene(fxmlLoader.load(), 500, 300);

        stage.setResizable(false);

        stage.setTitle("Hello! World?");
        stage.setScene(scene);
        stage.show();
    }


}