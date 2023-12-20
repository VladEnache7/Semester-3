package com.example.toylanguage6;

import com.example.toylanguage6.controller.Controller;
import com.example.toylanguage6.exceptions.InterpreterException;
import com.example.toylanguage6.model.ADTs.*;
import com.example.toylanguage6.model.ProgramState;
import com.example.toylanguage6.model.Statements.StatementInterface;
import com.example.toylanguage6.model.Values.StringValue;
import com.example.toylanguage6.model.Values.Value;
import com.example.toylanguage6.repository.Repository;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.util.Callback;

import java.util.Map;

public class ExecuteProgramController {
    private Controller controller = null;
    @FXML
    private TextField noOfPrograms;

    @FXML
    private ListView<ProgramState> programStates;

    @FXML
    private ListView<StatementInterface> executionStack;

    @FXML
    private TableView<Map.Entry<Integer, Value>> heapTable;

    @FXML
    private TableColumn<Map.Entry<Integer, Value>, String> addressColumnHeapTable;

    @FXML
    private TableColumn<Map.Entry<Integer, Value>, String> valueColumnHeapTable;

    @FXML
    private TableView<Map.Entry<String, Value>> symbolTable;

    @FXML
    private TableColumn<Map.Entry<String, Value>, String> symbolColumnSymbolTable;

    @FXML
    private TableColumn<Map.Entry<String, Value>, String> valueColumnSymbolTable;

    @FXML
    private ListView<Value> output;

    @FXML
    private ListView<StringValue> fileTable;

    @FXML
    private Button runOneStepButton;

    @FXML
    public void initialize() {
        this.runOneStepButton.setOnAction(actionEvent -> this.runOneStepButtonHandler());

        this.programStates.setCellFactory(new Callback<ListView<ProgramState>, ListCell<ProgramState>>() {
            @Override
            public ListCell<ProgramState> call(ListView<ProgramState> param) {
                return new ListCell<ProgramState>() {
                    @Override
                    protected void updateItem(ProgramState item, boolean empty) {
                        super.updateItem(item, empty);
                        if (item == null || empty)
                            setText("");
                        else
                            setText("Program " + item.getId_thread());
                    }
                };
            }
        });

        // set the selection mode for the program states list
        this.programStates.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);
        this.programStates.getSelectionModel().selectedItemProperty().addListener((observableValue, oldState, newState) -> {
            this.changeThreadState(newState);
        });

        // set the cell factory for the heap table
        this.addressColumnHeapTable.setCellValueFactory(param -> new SimpleStringProperty(param.getValue().getKey().toString()));
        this.valueColumnHeapTable.setCellValueFactory(param -> new SimpleStringProperty(param.getValue().getValue().toString()));

        // set the cell factory for the symbol table
        this.symbolColumnSymbolTable.setCellValueFactory(param -> new SimpleStringProperty(param.getValue().getKey()));
        this.valueColumnSymbolTable.setCellValueFactory(param -> new SimpleStringProperty(param.getValue().getValue().toString()));
    }
    public void setStatement(StatementInterface newStatement, String logFilePath) {
        ProgramState programState = new ProgramState(new MyStack<>(), new MyDictionary<>(), new MyList<>(),
                new MyDictionary<>(), new MyHeap<>(), newStatement);
        try {
            // initialize the repository and the controller for the new program
            Repository repo = new Repository(logFilePath);
            repo.addProgram(programState);
            this.controller = new Controller(repo);

            // update the GUI
            this.updateTables();
            this.programStates.getSelectionModel().selectFirst();

            this.runOneStepButton.setDisable(false);
        } catch (InterpreterException e) {
            e.printStackTrace();
        }
    }

    public void runOneStepButtonHandler(){
        try {
            this.controller.oneStepForAllProgramsGUI();
        } catch (InterpreterException e) {
            Alert alert = new Alert(Alert.AlertType.INFORMATION);
            alert.setContentText(e.getMessage());
            alert.showAndWait();
            this.runOneStepButton.setDisable(true);
        }
        finally {
            this.updateTables();
        }

    }

    public void setNoOfPrograms(){
        this.noOfPrograms.setText(String.valueOf(this.controller.getProgramStatesList().size()));
    }

    public void populateProgramStatesList(){
        this.programStates.setItems(FXCollections.observableList(this.controller.getProgramStatesList()));
    }

    public void populateExecutionStack(ProgramState programState){
        if (programState != null){
            ObservableList<StatementInterface> statements = FXCollections.observableArrayList();
            MyStackInterface<StatementInterface> exeStack = programState.getExecutionStack().deepCopy();

            while (!exeStack.isEmpty()){
                try {
                    statements.add(exeStack.pop());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            this.executionStack.getItems().setAll(statements);
        }
        else {
            this.executionStack.getItems().setAll(FXCollections.observableArrayList());
        }
    }

    public void populateHeapTable(){
        if(!this.controller.getProgramStatesList().isEmpty())
            this.heapTable.getItems().setAll(FXCollections.observableArrayList(this.controller.getHeapTable().getHeap().entrySet()));
    }

    public void populateSymbolTable(ProgramState state){
        if(state != null)
            this.symbolTable.getItems().setAll(FXCollections.observableArrayList(state.getSymbolTable().getContent().entrySet()));
        else
            this.symbolTable.getItems().setAll(FXCollections.observableArrayList());
    }

    public void populateOutput(){
        if(!this.controller.getProgramStatesList().isEmpty())
            this.output.getItems().setAll(FXCollections.observableArrayList(this.controller.getOutput().getList()));
    }

    public void populateFileTable(){
        if(!this.controller.getProgramStatesList().isEmpty())
            this.fileTable.getItems().setAll(FXCollections.observableArrayList(this.controller.getFileTable().getContent().keySet()));
    }

    private void updateTables(){
        this.setNoOfPrograms();
        this.populateProgramStatesList();
        this.changeThreadState(this.programStates.getSelectionModel().getSelectedItem());
        this.populateHeapTable();
        this.populateOutput();
        this.populateFileTable();
    }

    private void changeThreadState(ProgramState newState){
        this.populateSymbolTable(newState);
        this.populateExecutionStack(newState);
    }

}
