;a) A linear list is given. Eliminate from the list all elements from N to N steps, N-given.
;b) Write a function to test if a linear list of integer numbers has a "valley" aspect (a list has a valley 
;aspect if the items decrease to a certain point and then increase. Eg. 10 8 6 17 19 20). A list must have 
;at least 3 elements to fullfill this condition.
;c) Build a function that returns the minimum numeric atom from a list, at any level.
;d) Write a function that deletes from a linear list of all occurrences of the maximum element.

; ------------------------------- a) -------------------------------
; A linear list is given. Eliminate from the list all elements from N to N steps, N-given

; Mathematical model:
; removeN(l1...ln, n, i) = [], n = 0
;                         = l1 U removeN(l2...ln, n, i+1), i % n = 0
;                         = removeN(l2...ln, n, i+1), otherwise

; removeN(L - list, N - integer, I - index)
(defun removeN (lst n i)
    (cond
        ((null lst) nil)
        ((= (mod i n) 0) (removeN (cdr lst) n (+ i 1)))
        (t (cons (car lst) (removeN (cdr lst) n (+ i 1))))
    )
)

(defun removeNCaller(lst n)
    (removeN lst n 1)
)

; ------------------------------- b) -------------------------------
;b) Write a function to test if a linear list of integer numbers has a "valley" aspect (a list has a valley 
;aspect if the items decrease to a certain point and then increase. Eg. 10 8 6 17 19 20). A list must have 
;at least 3 elements to fullfill this condition.

; Mathematical model:
; valley(l1...ln, m) = true, n <= 1 and m = 0 (increasing)
;                  = valley(l2...ln, 1), l1 > l2 and m = 1 (decreasing)
;                  = valley(l2...ln, 0), l1 < l2 and m = 1 (the change from decreasing to increasing)
;                  = valley(l2...ln, 0), l1 < l2 and m = 0 (increasing)
;                  = false, otherwise

; valley(lst - list, M - monotony [0 - increasing, 1 - decreasing])
(defun valley (lst m)
    (cond 
        ((or (null lst) (null (cdr lst))) (= m 0)) ; if the list has 1 or 0 elements return true if it is increasing
        ((and (= m 1) (> (car lst) (cadr lst))) (valley (cdr lst) 1)) ; decreasing
        ((and (= m 1) (< (car lst) (cadr lst))) (valley (cdr lst) 0)) ; the change from decreasing to increasing
        ((and (= m 0) (< (car lst) (cadr lst))) (valley (cdr lst) 0)) ; increasing
        (t nil)
    )
)
; Mathematical model:
; valleyCaller(l1...ln) = valley(l1...ln, 0), if n >= 3 and l1 > l2
;                      = false, otherwise
(defun valleyCaller (lst)
    (cond
        ((< (length lst) 3) nil) ; a list must have at least 3 elements 
        ((> (car lst) (cadr lst)) (valley lst 1)) ; first is decreasing
        (t nil) 
    )
)

; ------------------------------- c) -------------------------------
;c) Build a function that returns the minimum numeric atom from a list, at any level.
; Mathematical model:
; minAll(l1..ln, m) = m, if n = 0
;                   = minAll(l2...ln, l1), if l1 is a atom and l1 < m
;                   = minAll(l2...ln, m), if l1 is a atom and l1 >= m
;                   = minAll(l2...ln, minAll(l1, m)), if l1 is a list

; minAll(lst - list, m - minimum)
(defun minAll (lst m)
    (cond
        ((null lst) m)
        ((and (atom (car lst)) (< (car lst) m)) (minAll (cdr lst) (car lst)))
        ((and (atom (car lst)) (>= (car lst) m)) (minAll (cdr lst) m))
        ((listp (car lst)) (minAll (cdr lst) (minAll (car lst) m)))
    )
)

; Mathematical model:
; minAllCaller(l1...ln) = minAll(l1...ln, l1), if n > 0
;                       = nil, otherwise
(defun minAllCaller (lst)
    (cond
        ((null lst) nil)
        (t (minAll (cdr lst) (car lst)))
    )
)






; ------------------------------- d) -------------------------------
;d) Write a function that deletes from a linear list of all occurrences of the maximum element.

; Mathematical model:
; findMax(l1...ln, m) = m, if n = 0
;                     = findMax(l2...ln, l1), if l1 > m
;                     = findMax(l2...ln, m), otherwise

; findMax(lst - list, m - maximum)
(defun findMax (lst m)
    (cond
        ((null lst) m)
        ((> (car lst) m) (findMax (cdr lst) (car lst)))
        (t (findMax (cdr lst) m))
    )
)

; Mathematical model:
; findMaxCaller(l1...ln) = findMax(l2...ln, l1), if n > 0
;                        = nil, otherwise
(defun findMaxCaller (lst)
    (cond
        ((null lst) nil)
        (t (findMax (cdr lst) (car lst)))
    )
)

; Mathematical model:
; deleteMax(l1...ln, m) = [], if n = 0
;                       = deleteMax(l2...ln, m), if l1 = m
;                       = l1 U deleteMax(l2...ln, m), otherwise

; deleteMax(lst - list, m - maximum)
(defun deleteMax (lst m)
    (cond
        ((null lst) nil)
        ((= (car lst) m) (deleteMax (cdr lst) m))
        (t (cons (car lst) (deleteMax (cdr lst) m)))
    )
)
; Mathematical model:
; deleteMaxCaller(l1...ln) = deleteMax(l1...ln, findMaxCaller(l1...ln)), if n > 0
;                          = nil, otherwise
(defun deleteMaxCaller (lst)
    (cond
        ((null lst) nil)
        (t (deleteMax lst (findMaxCaller lst)))
    )
)