;5. Write a function that computes the sum of even numbers and then subtract the sum of odd numbers, 
;at any level of a list.

; <------------- Mathematical Model ------------->
; diffEvenOdd(e) = 
;       { e, if e is even number
;       { -e, if e is odd
;       { 0, if e is atom
;       { sum(ei), i = 1,n if e = (e1..en)

(defun diffEvenOdd (e)
    (cond
        ((and (numberp e) (= 0 (mod e 2))) e)
        ((numberp e) (- e))
        ((atom e) 0)
        (t (apply #'+ (mapcar #'diffEvenOdd e)))
    )
)

(diffEvenOdd '(1 2 3 4)) ; (2 + 4) - (1 + 3) = 6 - 4 = 2
(diffEvenOdd '(10 5))
