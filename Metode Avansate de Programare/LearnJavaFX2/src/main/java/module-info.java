module com.example.learnjavafx2 {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.example.learnjavafx2 to javafx.fxml;
    exports com.example.learnjavafx2;
}