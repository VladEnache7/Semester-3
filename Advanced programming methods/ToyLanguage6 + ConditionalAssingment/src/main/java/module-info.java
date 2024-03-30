module com.example.toylanguage6 {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.example.toylanguage6 to javafx.fxml;
    exports com.example.toylanguage6;
}