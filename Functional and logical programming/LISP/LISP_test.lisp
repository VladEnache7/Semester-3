; <------------- Mathematical Model ------------->
;   countElem(l1..ln, e) =
;       { 0, if n = 0, the list is empty
;       { 1 + countElem(l2..ln, e), if l1 = e
;       { 0 + countElem(l2..ln, e), if l1 atom
;       { countElem(l1, e) + countElem(l2..ln, e), if l1 is list
(defun countElem (l e)
    (cond
        ((null l) 0)
        ((equal e (car l)) (+ 1 (countelem (cdr l) e)))
        ((atom (car l)) (countelem (cdr l) e))
        (t (+ (countElem (car l) e) (countelem (cdr l) e)))
    )
)

; <------------- Mathematical Model ------------->
; removeall(l1..ln, e) =
;       { [], if n = 0
;       { removeall(l1, e) U removeall(l2..ln, e), if l1 is a list
;       { removeall(l2..ln, e), if l1 = e
;       { l1 U removeall(l2..ln, e), otherwise
(defun removeall (l e)
    ((lambda (h tl)
        (cond
            ((null l) nil)
            ((listp h) (cons (removeall h e) (removeall tl e)))
            ((equal h e) (removeall tl e))
            (t (cons h (removeall tl e)))
        )
    ) (car l) (cdr l))
)

; <--------> Mathematical Model <-------->
;append2Lists(l1..ln, k1..km) =
;		{ k1..km, if n = 0
;		{ l2 U append2Lists(l2..ln, k1..km), otherwise
(defun append2Lists (l k)
	(cond 
		((null l) k)
		(t (cons (car l) (append2Lists (cdr l) k)))
	)
)

; <------------- Mathematical Model ------------->
; removeEven(l1..ln) =
;       { [], if n = 0, list is empty
;       { removeEven(removeAll(l2..ln, l1)), if countElem(l1..ln, l1) % 2 = 0 and l1 is number
;       { l1 U removeEven(l2..ln), l1 is atom
;       { removeEven(l1) U removeEven(l2..ln), l1 is list

(defun removeEven (l)
    (cond
        ((null l) nil)
        ((and (numberp (car l)) (= 0 (mod (countelem l (car l)) 2))) (removeEven (removeall l (car l))))
        ((atom (car l)) (cons (car l) (removeEven (cdr l))))
        (t (cons (removeEven (car l)) (removeEven (cdr l))))
    )
)

