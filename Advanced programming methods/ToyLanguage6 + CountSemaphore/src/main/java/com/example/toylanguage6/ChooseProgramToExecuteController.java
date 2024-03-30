package com.example.toylanguage6;

import com.example.toylanguage6.model.ADTs.MyDictionary;
import com.example.toylanguage6.model.Statements.StatementInterface;
import com.example.toylanguage6.view.Examples;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.ListView;
import javafx.collections.ObservableList;
import javafx.stage.Stage;

import java.io.IOException;

public class ChooseProgramToExecuteController {

    @FXML
    private ListView<StatementInterface> programsList;

    private ExecuteProgramController executeProgramController;

    @FXML
    public void initialize() {
        programsList.setItems(this.getStatements());

        FXMLLoader fxmlLoader = new FXMLLoader(HelloApplication.class.getResource("ExecuteProgram.fxml"));
        Stage stage = new Stage();
        try {
            Scene scene = new Scene(fxmlLoader.load(), 1350, 450);
            this.executeProgramController = fxmlLoader.getController();
            stage.setScene(scene);
            stage.show();
        } catch (IOException exception) {
            exception.printStackTrace();
        }

        programsList.getSelectionModel().selectedItemProperty().addListener(new ChangeListener<StatementInterface>() {
            @Override
            public void changed(ObservableValue<? extends StatementInterface> observableValue, StatementInterface oldStatement, StatementInterface newStatement) {
                String filename = "log" + (programsList.getSelectionModel().getSelectedIndex()+1)+ ".txt";
                executeProgramController.setStatement(newStatement, filename);
            }
        });
    }

    private ObservableList<StatementInterface> getStatements() {
        ObservableList<StatementInterface> exampleList = FXCollections.observableArrayList();
        StatementInterface[] examples = new Examples().exampleList();
        for(StatementInterface example: examples){
            try{
                example.typeCheck(new MyDictionary<>());
                exampleList.add(example);
            } catch (Exception e){
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Typecheck error");
                alert.setHeaderText("Typecheck error");
                alert.setContentText("Program that did not pass:\n" + example.toString() + "\n due to:\n" + e.getMessage());
                alert.showAndWait();
            }
        }
        return exampleList;
    }


}