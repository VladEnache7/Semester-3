import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class WrittenExs {
    public static void main(String[] args) {
        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14,15);

        // Exercise 1 Map 22 January 2024
        String result = numbers.stream()
                        .filter(x -> {return x % 5 == 0 || x % 3 == 0;}) // filter out all numbers that are not divisible by 5 or 3
                        .map(x -> "N" + Integer.toString(x) + "R") // map all numbers to strings that start with N and end with R
                        .collect(Collectors.joining("")); // join all strings with a comma

//        System.out.println(result);

        // Exercise 1 Map 25 January 2024
        int result2 = numbers.stream()
                .filter(x -> {return x % 3 == 0 || x % 7 == 0;}) // filter out all numbers that are not divisible by 3 or 7
                .map(x -> (x - 1) * 10) // map all numbers to the result of subtracting 1 and multiplying by 10
                .reduce(0, (x, y) -> (x + y) % 5); // computes the sum modulo 5 of the remaining numbers

        System.out.println(numbers.stream()
                .filter(x -> {return x % 3 == 0 || x % 4 == 0;})
                .map(x -> (x + 1) % 3)
                .reduce(0, (x, y) -> (x + y) % 2)
        );
    }
}
