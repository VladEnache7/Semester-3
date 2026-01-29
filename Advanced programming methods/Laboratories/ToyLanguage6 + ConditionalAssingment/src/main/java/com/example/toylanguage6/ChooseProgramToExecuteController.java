package com.example.toylanguage6;

import com.example.toylanguage6.model.ADTs.MyDictionary;
import com.example.toylanguage6.model.Expressions.*;
import com.example.toylanguage6.model.Statements.*;
import com.example.toylanguage6.model.Types.BoolType;
import com.example.toylanguage6.model.Types.IntType;
import com.example.toylanguage6.model.Types.RefType;
import com.example.toylanguage6.model.Types.StringType;
import com.example.toylanguage6.model.Values.BoolValue;
import com.example.toylanguage6.model.Values.IntValue;
import com.example.toylanguage6.model.Values.StringValue;
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
import javafx.util.Pair;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
        for(StatementInterface example: getExamples()){
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

    private ObservableList<StatementInterface> getExamples() {
        List<StatementInterface> allStatements = new ArrayList<>();

        // int v; v = 2; Print(v)
        /*This is the correct one*/
        StatementInterface example1 = new CompoundStatement(
                new VariableDeclarationStatement("v", new IntType()),
                new CompoundStatement(
                        new AssignStatement("v", new ValueExpression(new IntValue(2))),
                        new PrintStatement(new VariableExpression("v"))
                )
        );
        allStatements.add(example1);

        // int a; int b; a = 2 + 3 * 5; b = a + 1; Print(b)
        StatementInterface example2 = new CompoundStatement(
                new VariableDeclarationStatement("a", new IntType()),
                new CompoundStatement(
                        new VariableDeclarationStatement("b", new IntType()),
                        new CompoundStatement(
                                new AssignStatement(
                                        "a",
                                        new ArithmeticExpression(
                                                '+',
                                                new ValueExpression(new IntValue(2)),
                                                new ArithmeticExpression('*',
                                                        new ValueExpression(new IntValue(3)),
                                                        new ValueExpression(new IntValue(5))
                                                )
                                        )
                                ),
                                new CompoundStatement(
                                        new AssignStatement(
                                                "b",
                                                new ArithmeticExpression('+',
                                                        new VariableExpression("a"),
                                                        new ValueExpression(new IntValue(1))
                                                )
                                        ),
                                        new PrintStatement(new VariableExpression("b"))
                                )
                        )
                )
        );
        allStatements.add(example2);
        // bool a; int v; a = true; (If a Then v = 2 Else v = 3); Print(v)
        StatementInterface example3 = new CompoundStatement(
                new VariableDeclarationStatement("a", new BoolType()),
                new CompoundStatement(
                        new VariableDeclarationStatement("v", new IntType()),
                        new CompoundStatement(
                                new AssignStatement("a", new ValueExpression(new BoolValue(true))),
                                new CompoundStatement(
                                        new IfStatement(
                                                new VariableExpression("a"),
                                                new AssignStatement("v", new ValueExpression(new IntValue(2))),
                                                new AssignStatement("v", new ValueExpression(new IntValue(3)))
                                        ),
                                        new PrintStatement(new VariableExpression("v"))
                                )
                        )
                )
        );
        allStatements.add(example3);
        // string varf; varf = "test.in"; openRFile(varf); int varc; readFile(varf, varc); print(varc); readFile(varf, varc); print(varc); closeRFile(varf)
        StatementInterface example4 = new CompoundStatement(
                new VariableDeclarationStatement("varf", new StringType()),
                new CompoundStatement(
                        new AssignStatement("varf", new ValueExpression(new StringValue("test.in"))),
                        new CompoundStatement(
                                new OpenReadFileStatement(new VariableExpression("varf")),
                                new CompoundStatement(
                                        new VariableDeclarationStatement("varc", new IntType()),
                                        new CompoundStatement(
                                                new ReadFileStatement(new VariableExpression("varf"), "varc"),
                                                new CompoundStatement(
                                                        new PrintStatement(new VariableExpression("varc")),
                                                        new CompoundStatement(
                                                                new ReadFileStatement(new VariableExpression("varf"), "varc"),
                                                                new CompoundStatement(
                                                                        new PrintStatement(new VariableExpression("varc")),
                                                                        new CloseReadFileStatement(new VariableExpression("varf"))
                                                                )
                                                        )
                                                )
                                        )
                                )
                        )
                )
        );
        allStatements.add(example4);

        // Ref int v;new(v,20);Ref Ref int a; new(a,v);print(v);print(a)
        StatementInterface example5 = new CompoundStatement(
                new VariableDeclarationStatement("v", new RefType(new IntType())),
                new CompoundStatement(
                        new HeapAllocationStatement("v", new ValueExpression(new IntValue(20))),
                        new CompoundStatement(
                                new VariableDeclarationStatement("a", new RefType(new RefType(new IntType()))),
                                new CompoundStatement(
                                        new HeapAllocationStatement("a", new VariableExpression("v")),
                                        new CompoundStatement(
                                                new PrintStatement(new VariableExpression("v")),
                                                new PrintStatement(new VariableExpression("a"))
                                        )
                                )
                        )
                )
        );
        allStatements.add(example5);

        //  Ref int v;new(v,20);Ref Ref int a; new(a,v);print(rH(v));print(rH(rH(a))+5)
        StatementInterface example6 = new CompoundStatement(
                new VariableDeclarationStatement("v", new RefType(new IntType())),
                new CompoundStatement(
                        new HeapAllocationStatement("v", new ValueExpression(new IntValue(20))),
                        new CompoundStatement(
                                new VariableDeclarationStatement("a", new RefType(new RefType(new IntType()))),
                                new CompoundStatement(
                                        new HeapAllocationStatement("a", new VariableExpression("v")),
                                        new CompoundStatement(
                                                new PrintStatement(new HeapReadingExpression(new VariableExpression("v"))),
                                                new PrintStatement(new ArithmeticExpression('+',
                                                        new HeapReadingExpression(new HeapReadingExpression(new VariableExpression("a"))),
                                                        new ValueExpression(new IntValue(5))
                                                ))
                                        )
                                )
                        )
                )
        );
        allStatements.add(example6);

        //  Ref int v;new(v,20);print(rH(v)); wH(v,30);print(rH(v)+5);
        StatementInterface example7 = new CompoundStatement(
                new VariableDeclarationStatement("v", new RefType(new IntType())),
                new CompoundStatement(
                        new HeapAllocationStatement("v", new ValueExpression(new IntValue(20))),
                        new CompoundStatement(
                                new PrintStatement(new HeapReadingExpression(new VariableExpression("v"))),
                                new CompoundStatement(
                                        new HeapWritingStatement("v", new ValueExpression(new IntValue(30))),
                                        new PrintStatement(new ArithmeticExpression('+',
                                                new HeapReadingExpression(new VariableExpression("v")),
                                                new ValueExpression(new IntValue(5))
                                        ))
                                )
                        )
                )
        );
        allStatements.add(example7);

        //  int v; v=4; (while (v>0) print(v);v=v-1);print(v)
        StatementInterface example8 = new CompoundStatement(
                new VariableDeclarationStatement("v", new IntType()),
                new CompoundStatement(
                        new AssignStatement("v", new ValueExpression(new IntValue(4))),
                        new CompoundStatement(
                                new WhileStatement(
                                        new RelationalExpression(
                                                ">",
                                                new VariableExpression("v"),
                                                new ValueExpression(new IntValue(0))
                                        ),
                                        new CompoundStatement(
                                                new PrintStatement(new VariableExpression("v")),
                                                new AssignStatement(
                                                        "v",
                                                        new ArithmeticExpression(
                                                                '-',
                                                                new VariableExpression("v"),
                                                                new ValueExpression(new IntValue(1))
                                                        )
                                                )
                                        )
                                ),
                                new PrintStatement(new VariableExpression("v"))
                        )
                )
        );
        allStatements.add(example8);

        // int v; Ref int a; v=10;new(a,22);
        // fork(wH(a,30);v=32;print(v);print(rH(a)));
        // print(v);print(rH(a))
        StatementInterface example9 = new CompoundStatement(
                new VariableDeclarationStatement("v", new IntType()),
                new CompoundStatement(
                        new VariableDeclarationStatement("a", new RefType(new IntType())),
                        new CompoundStatement(
                                new AssignStatement("v", new ValueExpression(new IntValue(10))),
                                new CompoundStatement(
                                        new HeapAllocationStatement("a", new ValueExpression(new IntValue(22))),
                                        new CompoundStatement(
                                                new ForkStatement(
                                                        new CompoundStatement(
                                                                new HeapWritingStatement("a", new ValueExpression(new IntValue(30))),
                                                                new CompoundStatement(
                                                                        new AssignStatement("v", new ValueExpression(new IntValue(32))),
                                                                        new CompoundStatement(
                                                                                new PrintStatement(new VariableExpression("v")),
                                                                                new PrintStatement(new HeapReadingExpression(new VariableExpression("a")))
                                                                        )
                                                                )
                                                        )
                                                ),
                                                new CompoundStatement(
                                                        new PrintStatement(new VariableExpression("v")),
                                                        new PrintStatement(new HeapReadingExpression(new VariableExpression("a")))
                                                )
                                        )
                                )
                        )
                )
        );
        allStatements.add(example9);


        // bool b; int c; b = true; c = b ? 100 : 200; print(c); c = (false) ? 100 : 200; print(c);

        StatementInterface example10 = new CompoundStatement(
                new VariableDeclarationStatement("b", new BoolType()),
                new CompoundStatement(
                        new VariableDeclarationStatement("c", new IntType()),
                        new CompoundStatement(
                                new AssignStatement("b", new ValueExpression(new BoolValue(true))),
                                new CompoundStatement(
                                        new ConditionalAssignmentStatement("c",
                                                new VariableExpression("b"),
                                                new ValueExpression(new IntValue(100)),
                                                new ValueExpression(new IntValue(200))
                                        ),
                                        new CompoundStatement(
                                                new PrintStatement(new VariableExpression("c")),
                                                new CompoundStatement(
                                                        new ConditionalAssignmentStatement("c",
                                                                new ValueExpression(new BoolValue(false)),
                                                                new ValueExpression(new IntValue(100)),
                                                                new ValueExpression(new IntValue(200))
                                                        ),
                                                        new PrintStatement(new VariableExpression("c"))
                                                )
                                        )
                                )
                        )
                )
        );

        allStatements.add(example10);

        return FXCollections.observableArrayList(allStatements);
    }

}