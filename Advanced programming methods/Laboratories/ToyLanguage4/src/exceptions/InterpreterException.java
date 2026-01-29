package exceptions;

public class InterpreterException extends Exception {
    // constructor of the exception - the place where the specific message will be set
    public InterpreterException(String message){
        super(message);
    }
    // returns the specific message of the exception thrown
    @Override
    public String getMessage(){
        return super.getMessage();
    }
}
