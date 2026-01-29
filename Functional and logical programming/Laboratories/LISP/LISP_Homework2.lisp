
; 1. For a given tree of type (1) return the path from the root node to a certain given node X.

; nv = nr of vertices, ne = nr of edges
; Mathematical model
; traverseLeft(l1..ln, nv, ne) =
; 	{ [], n = 0
;   { [], if nv = ne + 1
;   { l1 U l2 U parcurg_st(l3...ln, nv+1, nm+l2)
(defun traverseLeft (tree nv ne)
    (cond
        ((null tree) nil)
        ((= nv (+ ne 1)) nil)
        (t (cons (car tree)
                (cons (cadr tree)
                    (traverseLeft (cddr tree) (+ nv 1) (+ ne (cadr tree))))))))


; Mathematical model
; leftTree(l1..ln) =
;   { traverseLeft(l2..ln, 0, 0), if n > 0
(defun leftTree (tree)
     (traverseLeft (cddr tree) 0 0))

; Mathematical model
; traverseRight(l1..ln, nv, ne) =
; 	{ [], n = 0
;   { l1..ln, if nv = ne + 1
;   { traverseRight(l3..ln, nv+1, nm+l2), otherwise
(defun traverseRight (tree nv ne)
    (cond
        ((null tree) nil)
        ((= nv (+ ne 1)) tree)
        (t (traverseRight (cddr tree) (+ nv 1) (+ ne (cadr tree))))))

; Mathematical model
; rightTree(l1..ln) =
;   { traverseRight(l2..ln, 0, 0), if n > 0
(defun rightTree (tree)
    (traverseRight (cddr tree) 0 0))

; Mathematical model
; my_append(l1..ln, m1..mn) =
;   { m1..mn, if n = 0
;   { l1 U my_append(l2..ln, m1..mn), otherwise
(defun my_append (list1 list2)
    (cond
        ((null list1) list2)
        (t (cons (car list1) (my_append (cdr list1) list2)))
    )
)


; Mathematical model
; findPathAux(l1..ln, elem, path) =
;   { [], if elem does not exist in the tree
;   { path, if elem = l1
;   { findPathAux(leftTree(l1..ln), elem, path U l1)
;   { findPathAux(rightTree(l1..ln), elem, path U l1)
(defun findPathAux (tree elem path)
    (cond
        ((null tree) nil)
        ((equal elem (car tree)) (my_append path (list elem)))
        ((findPathAux (leftTree tree) elem (my_append path (list (car tree)))))
        ((findPathAux (rightTree tree) elem (my_append path (list (car tree)))))
    )
)

; Mathematical model
; findPath(l1..ln, elem) =
;   { findPathAux(l1..ln, elem, []), if n > 0
(defun findPath (tree elem)
    (findPathAux tree elem nil))

