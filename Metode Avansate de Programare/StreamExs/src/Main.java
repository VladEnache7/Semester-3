import java.lang.reflect.Array;
import java.util.List;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static void main(String[] args) {
        List<String> words = List.of("Hello", "world", "!", "How", "are", "you", "?", "I", "am", "fine", "thanks", "for", "asking", ".");
//        words.forEach(s -> {System.out.println(".  " + s + "  .");});
//        words.forEach(System.out::println);
//        List<String> excitingWords = words.stream()
//                .map(word -> word + "!")
//                .toList();
//        System.out.println(excitingWords);
//        List<String> eyeWords = words.stream()
//                .map(word -> word.replace("i", "eye"))
//                .toList();
//        System.out.println(eyeWords);
//        List<String> upperCaseWords = words.stream()
//                .map(String::toUpperCase)
//                .toList();
//        System.out.println(upperCaseWords);
//        List<String> shortWords = words.stream()
//                .filter(word -> word.length() < 4)
//                .toList();
//        System.out.println(shortWords);
//        List<String> wordsWithB = words.stream()
//                .filter(word -> word.contains("b"))
//                .toList();
//        System.out.println(wordsWithB);
//        List<String> evenLengthWords = words.stream()
//                .filter(word -> word.length() % 2 == 0)
//                .toList();
//        System.out.println(evenLengthWords);
//        List<String> exercise5 = words.stream()
//                .map(String::toUpperCase)
//                .filter(word -> word.length() < 4)
//                .filter(word -> word.contains("E"))
//                .toList();
//        System.out.println(exercise5);
//        Function<String, Optional<String>> processWords = letter -> words.stream()
//                .map(String::toUpperCase)
//                .filter(word -> word.length() < 4)
//                .filter(word -> word.contains(letter))
//                .findFirst();
//
//        Optional<String> firstEWord = processWords.apply("E");
//        firstEWord.ifPresent(System.out::println);
//
//        Optional<String> firstQWord = processWords.apply("O");
//        firstQWord.ifPresent(System.out::println);
//        String exercise6 = words.stream()
//                .reduce((s1, s2) -> s1.toUpperCase() + s2.toUpperCase())
//                .toString();
//        System.out.println(exercise6);
        String exercise6 = words.stream()
                .map(String::toUpperCase)
                .reduce("", (s1, s2) -> s1 + s1);

        System.out.println(exercise6);

//        Optional<String> upperCaseString = words.stream()
//                .map(String::toUpperCase)
//                .reduce((s1, s2) -> s1 + s2);
//
//        upperCaseString.ifPresent(System.out::println);
    }
}