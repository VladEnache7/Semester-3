;---------------------------------------------------------- 1 a) ---------------------------------------------------------
;a) Write a function to return the n-th element of a list, or NIL if such an element does not exist.

; ------------Mathematical model------------
;nthelem(l1..ln, k) = 
;       { nil, n = 0
;       { l1, k = 0
;       { nth(l2..ln, k - 1), otherwise
(defun nthelem (l k)
    (cond
        ((null l) nil)
        ((= k 1) (car l))
        (t (nthelem (cdr l) (- k 1) ))
    )
)

;--------------------------------------------------------- 1 b) ---------------------------------------------------------

;b) Write a function to check whether an atom E is a member of a list which is not necessarily linear.

; ------------Mathematical model------------
; ismember(e, l1..ln) = 
;       { nil/false, n = 0
;       { true, l1 = e
;       { ismember(e, l1) or ismember(e, l2..ln), if l1 is a list
;       { ismember(e, l2..ln), otherwise
(defun ismember (e l)
    (cond
        ((null l) nil)
        ((equal (car l) e) t)
        ((listp (car l)) (or (ismember e (car l))  (ismember e (cdr l))))
        (t (ismember e (cdr l)))
    )
)

; <------------- Mathematical Model ------------->
; myor(l) =
;       { false, l is nil
;       { true, l atom
;       { myor(l2..ln), 
;       {
(defun myor (l)
    (cond
        ((null l) nil)
        ((car l) t)
        (t (myor (cdr l)))
    )
)

; <------------- Mathematical Model ------------->
; isMember2(e, l) =
;       { true, e = l
;       { false, e != l
;       { myor (isMember2(e, li)), i = 1,n l = (l1..ln)
(defun ismember2 (e l)
    (cond
        ((equal e l) t)
        ((atom l) nil)
        (t (myor (mapcar #'(lambda (l) (ismember2 e l)) l)))
    )
)

;--------------------------------------------------------- 1 c) ---------------------------------------------------------

;c) Write a function to determine the list of all sublists of a given list, on any level. 
; A sublist is either the list itself, or any element that is a list, at any level. Example: 
; (1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 sublists :
; ( (1 2 (3 (4 5) (6 7)) 8 (9 10)) (3 (4 5) (6 7)) (4 5) (6 7) (9 10) )

; ------------Mathematical model------------
; my_append(l1..ln, m1..mn) =
;   { m1..mn, if n = 0
;   { l1 U my_append(l2..ln, m1..mn), otherwise
(defun my_append (list1 list2)
    (cond
        ((null list1) list2)
        (t (cons (car list1) (my_append (cdr list1) list2)))
    )
)

; ------------Mathematical model------------
; sublists(l1..ln) = 
;       { [], n = 0
;       { (l1 U sublists(l1)) U sublists(l2..ln), if l1 is a list
;       { sublists(l2..ln), otherwise
(defun sublists (lst)
    (cond 
        ((null lst) nil)
        ((listp (car lst)) (my_append (my_append (list (car lst)) (sublists (car lst))) (sublists (cdr lst))))
        ((sublists (cdr lst)))
    )
)

(defun mainsublists (lst)
    (cons lst (sublists lst))
)

;--------------------------------------------------------- 1 d) ---------------------------------------------------------

;d) Write a function to transform a linear list into a set.

; <------------- Mathematical Model ------------->
; removeAll(e, l) = 
;       { nil, e = l
;       { l, e != l
;       { U removeAll(li), i = 1,n l = (l1..ln)
(Defun removeAll (e l)
    (cond
        ((equal e l) nil)
        ((atom l) (list l))
        (t (mapcan #'(lambda (l) (removeall e l)) l))
    )
)

; <------------- Mathematical Model ------------->
; listtoset(l1..ln) = 
;       { [], if n = 0
;       { l1 U listtoset(removeAll(l1, l2..ln)), otherwise
(defun listtoset (l)
    (cond
        ((null l) nil)
        (t (myappendall (car l) (listtoset (removeall (car l) (cdr l)))))
    )
)

;--------------------------------------------------------- 2 a) ---------------------------------------------------------

;2.a) Write a function to return the product of two vectors.
(defun vectorProduct2 (l1 l2)
    (cond
        ((= (length l1) (length l2)) (mapcar #'* l1 l2))
        (t (error "The 2 vectors have different lengths"))
    )   
)

(defun vectorProduct (l1 l2)
    (cond
        ((null l1) nil)
        (t (cons (* (car l1) (car l2)) (vectorproduct (cdr l1) (cdr l2))))
    )
)

;--------------------------------------------------------- 2 c) ---------------------------------------------------------

; c) Write a function to sort a linear list without keeping the double values.

; <------------- Mathematical Model ------------->
; myAppend(l1..ln, b1..bm) = 
;       { b1..bm, if n = 0
;       { l1 U myAppend(l2..ln, b1..bm), otherwize
(defun myappend (list1 list2)
    (cond
        ((null list1) list2)
        (t (cons (car list1) (myappend (cdr list1) list2)))
    )
)

; <------------- Mathematical Model ------------->
; myAppendAll (l, other) = 
;       { l, if other is null
;       { myAppendAll(other), if l is null
;       { l U myAppendAll(other), l is atom 
;       { l U myAppendAll(other), l is list 

(defun myappendall (l &rest other)
    (cond
        ((null other) l)
        ((null l) (apply #'myappendall other))
        ((atom l) (myappend (list l) (apply #'myappendall other))) ; here apply is needee because it takes the other list and give the elements as parameters to myappendall
        (t (myappend l (apply #'myappendall other)))    ; apply works with a linear list, it will aplly myappend on the last 2, than the result on ln-2 and so on
    )                                                   ; while mapcar apply the function on each individual element and return the result
)


; <------------- Mathematical Model ------------->
; insertNode(e, tree) = 
;       { [e], if tree is empty
;       { tree, if tree(1) = e
;       { list(tree(1) U insertNode(e, tree(2)) U tree(3)), if e < tree(1)
;       { list(tree(1) U tree(2) U insertNode(e, tree(3))), otherwise 

(defun insertNode (e tree)
    (cond
        ((null tree) (list e))
        ((equal (car tree) e) tree)
        ((< e (car tree)) (list (car tree) (insertNode e (cadr tree)) (caddr tree)))
        (t (list (car tree) (cadr tree) (insertNode e (caddr tree))))
    )
)



; <------------- Mathematical Model ------------->
; constructTree(l1..ln) =
;       { [], if n = 0
;       { insertNode(l1, constructTree(l2..ln))
(Defun constructTree (l)
    (cond
        ((null l) nil)
        (t (insertnode (car l) (constructtree (cdr l))))
    )
)


; <------------- Mathematical Model ------------->
; inorder(t - tree) =
;       { [], if t is empty
;       { inorder(tree(2)) U tree(1) U inorder(tree(3)), otherwise
(defun inorder (tree)
    (cond
        ((null tree) nil)
        (t (myappendall (inorder (cadr tree)) (car tree) (inorder (caddr tree))))
    )
)

; <------------- Mathematical Model ------------->
;  sortare(l) = inorder(constructTree(l))
(defun sortare (l)
    (inorder (constructtree l))
)

;--------------------------------------------------------- 2 d) ---------------------------------------------------------

; d) Write a function to return the intersection of two sets.


; <------------- Mathematical Model ------------->
; intersect(l1..ln - first list, k1..km - second list) =
;       { [], if n = 0
;       { l1 U intersect(l2..ln, k), if l1 is member of k
;       { intersect(l2..ln, k), otherwise
(defun intersect (l k)
    (cond
        ((null l) nil)
        ((ismember2 (Car l) k) (cons (Car l) (intersect (cdr l) k)))
        (t (intersect (cdr l) k))
    )
)

;--------------------------------------------------------- 3 b) ---------------------------------------------------------

; <------------- Mathematical Model ------------->
;   myreverse2(l1..ln) =
;       { [], if n = 0 
;       { myreverse2(l2..ln) U l1, otherwise
(defun myreverse2 (l)
    (cond
        ((null l) nil)
        (t (myAppend (myReverse2 (cdr L)) (LIST (car L))))
    )
)

; <------------- Mathematical Model ------------->
; reverseall(l)
;       { [l], if l atom
;       { U myreverse2(l(i)), i = 1,n
;       {
;       {
(defun reverseall (l)
    (cond
        ((atom l) (list l))
        (t (mapcan #'reverseall (myreverse2 l)))
    )
)

;--------------------------------------------------------- 3 c) ---------------------------------------------------------

; c) Write a function that returns the greatest common divisor of all numbers in a nonlinear list.

;<------------- Mathematical Model ------------->
; cmmdc(n1, n2) = 
;       { n1, if n2 is null
;       { n2, if n1 is null
;       { n1, if n2 = 0
;       { cmmdc(n2, n1 mod n2), otherwise
(defun cmmdc (n1 n2)
    (cond
        ((zerop n2) n1)
        (t (cmmdc n2 (mod n1 n2)))
    )
)

(defun cmmdcaux (n1 n2)
    (cond
        ((not (numberp n1)) n2)
        ((not (numberp n2)) n1)
        (t (cmmdc n1 n2))
    )
)

; <------------- Mathematical Model ------------->
;   cmmdcAll(l) =
;       { l, if l atom
;       { cmmdc(l1, cmmdcall(l2..ln)), if l1 atom
;       { cmmdc(cmmdcall(l1), cmmdcall(l2..ln)), if l1 list
(defun cmmdcall (l)
    (cond
        ((numberp l) l)
        ((atom l) nil)
        ((atom (Car l)) (cmmdcaux (car l) (cmmdcall (cdr l))))
        (t (cmmdcaux (cmmdcall (car l)) (cmmdcall (cdr l))))
    )
)

