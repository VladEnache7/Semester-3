
;   ---------------------------------------------- I 1 ----------------------------------------------
; Give a solution to avoid double recursive call
(defun f (l1 l2)
    (cond
        ((null l1) (append (f (car l1) l2) (cdr l2)))
        (t (list (append (f (car l1) l2) (f (car l1) l2) (Car l2))))
    )
)

(defun f (l1 l2)
    ((lambda (res)
        (append res
            (cond
                ((null l1) (cdr l2))
                (t (list res (Car l2)))
            )
        ))
    (f (car l1) l2))
)

;   ---------------------------------------------- III ----------------------------------------------
; A nonlinear list is given. Write a LISP function to remove all numeric atoms divisible
; with 3 from all levels. Use a MAP function


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
; <--------> Mathematical Model <-------->
; Appends lists and atoms
; appendAll(l, other) =
;		{ [l], atom and other is empty
;		{ l, if other is empty
;		{ appendAll(other), if l is null
;		{ [l] U appendAll(other), l is atom
;		{ l U appendAll(other), otherwise
(defun appendAll (l &rest other)
	(cond
		;((and (atom l) (null other) (list l))
		((null other) l)
		((null l) (apply #'appendAll other)) 
		((atom l) (append2Lists (list l) (apply #'appendAll other)))
		(t (append2Lists l (apply #'appendAll other)))
	)
)


; <--------> Mathematical Model <-------->
;removeDiv3(l) =
;		{ [], if l number and l % 3 = 0
;		{ l, if l atom
;		{ appendAll(removeDiv3(l(i))), i = 1,n otherwise
(defun removeDiv3 (l)
	(cond
		((and (numberp l) (= 0 (mod l 3))) nil)
		((atom l) (list l))
		(t (list (mapcan #'removeDiv3 l)))
	)
)

(defun removeDiv3Main (l)
    (car (removediv3 l))
)


;   ---------------------------------------------- I 1 ----------------------------------------------
; Give a solution to avoid double recursive call

(defun fct (f l)
    (cond
        ((null l) nil)
        ((funcall f (car l)) (cons (funcall f (Car l)) (fct f (cdr l))))
        (t nil)
    )
)

; =======>

(defun fct2 (f l)
    (cond
        ((null l) nil)
        ((lambda (result) (result (cons result (fct2 f (cdr l))))) (funcall f (car l)))
        (t nil)
    )
)

(defun fct3 (f l)
    ((lambda (result)
        (cond
            ((null l) nil)
            (result (cons result (fct3 f (cdr l))))
            (t nil)
        ) 
    ) (funcall f (car l)))
)

;   ---------------------------------------------- III ----------------------------------------------
; Write a function to replace all nodes from the odd levels in the n-ary tree with a value E. The level of root is 0. Use a MAP function


; <------------- Mathematical Model ------------->
; replaceOdd(tree, elem - the element to replace with, level - the current level) 
;       { [], if tree is null
;				{ elem, if tree is atom and level is odd
;				{ tree, if tree is atom
;       { replaceOdd(tree(i), elem, level + 1), i = 1,n if level is odd

; (defun replaceOdd (tree e l)
; 		(cond
; 				((null tree) nil)
; 				((and (atom tree) (= 0 (mod l 2))) (list e))
; 				((atom tree) (list tree))
; 				(t (list (mapcan #'(lambda (tree) (replaceOdd tree e (+ l 1))) tree)))
; 		)
; )

(defun replaceOdd (tree e &optional (l 0))
		(cond
				((null tree) nil)
				((and (atom tree) (= 0 (mod l 2))) nil)
				((atom tree) tree)
				(t (mapcar #'(lambda (tree) (replaceOdd tree e (+ l 1))) tree))
		)
)

; <------------- Mathematical Model ------------->
; replaceOddMain(tree, elem) = replaceOdd(tree, elem, 0)
(defun replaceOddMain (tree e)
		(replaceOdd tree e 0)
)

(defun replaceEven (e)
    (cond
        ((and (numberp e) (= 0 (mod e 2))) (+ 1 e))
        ((atom e) e)
        (t (mapcar #'replaceEven e))
    )
)