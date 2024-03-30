men(vlad).
men(george).

% nth_element(L - initial list, n - integer, Element - resulted element)
% flow model: (i, i, i), (i, i, o)

% the case when list is empty
nth_element([], _, _).
% when it finds the element
nth_element([Head|_], 1, Element) :- 
    Element is Head.
% the recursion
nth_element([_|Tail], N, Element):-
    N1 is N - 1,
    nth_element(Tail, N1, Element).


% write in Prolog all the functions necessary for merging 2 strictly ascending lists into one, without duplicates
% Above is an example'
% merge(L1 - first list, L2 - second list, R - resulted list)
% flow model: (i, i, o), (i, i, i)

% the case when the first list is empty
merge([], L2, L2).
% the case when the second list is empty
merge(L1, [], L1).
% the case when the first element of the first list is smaller than the first element of the second list
merge([Head1|Tail1], [Head2|Tail2], Result) :-
    Head1 < Head2,
    merge(Tail1, [Head2|Tail2], Result1),
    Result = [Head1|Result1].

% the case when the first element of the first list is bigger than the first element of the second list
merge([Head1|Tail1], [Head2|Tail2], Result) :-
    Head1 > Head2,
    merge([Head1|Tail1], Tail2, Result1),
    Result = [Head2|Result1].

% the case when the first element of the first list is equal to the first element of the second list
merge([Head1|Tail1], [Head2|Tail2], Result) :-
    Head1 =:= Head2,
    merge(Tail1, Tail2, Result1),
    Result = [Head1|Result1].

%### => Define a predicate to produce a list of pairs (atom n) from an initial list of atoms. In this initial list atom has n occurrences.### => Define a predicate to produce a list of pairs (atom n) from an initial list of atoms. In this initial list atom has n occurrences.

% count_occurrences(L - initial list, E - element, R - resulted list)
% flow model: (i, i, o), (i, i, i)

% the case when the list is empty
count_occurrences([], _, 0).
% the case when the element is the first element of the list
count_occurrences([Head|Tail], Head, Result) :-
    count_occurrences(Tail, Head, Result1),
    Result is Result1 + 1.

% the case when the element is not the first element of the list
count_occurrences([_|Tail], Element, Result) :-
    count_occurrences(Tail, Element, Result).

% remove_duplicates(L - initial list, R - resulted list)
% flow model: (i, o), (i, i)

% the case when the list is empty
remove_duplicates([], []).
% the case when the element is the first element of the list
remove_duplicates([Head|Tail], Result) :-
    count_occurrences(Tail, Head, Result1),
    Result1 =:= 0,
    remove_duplicates(Tail, Result2),
    Result = [Head|Result2].

% the case when the element is not the first element of the list
remove_duplicates([Head|Tail], Result) :-
    count_occurrences(Tail, Head, Result1),
    Result1 =\= 0,
    remove_duplicates(Tail, Result2),
    Result = Result2.

% create_list(L - initial list, R - resulted list)
% flow model: (i, o), (i, i)

% the case when the list is empty
create_list([], []).
% the case when the element is the first element of the list
create_list([Head|Tail], Result) :-
    count_occurrences(Tail, Head, Result1),
    Result2 = [Head, Result1],
    create_list(Tail, Result3),
    Result = [Result2|Result3].




