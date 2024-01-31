
; Mathematical model
; myReverse(l1..ln) = {
;	    { [], n = 0
;	    { myReverse(l2..ln) U myReverse(l1), l1 is list
;	    { myReverse(l2..ln) U l1, otherwise
(defun myReverse (L)
    (cond
        ((null L) nil) ; if the list is null, return NIL
        ((listp (car L)) (myAppend (myReverse (CDR L)) (LIST (myReverse (CAR L))))) ; if the head is a list, also apply MY_REVERSE on that list
        (T (myAppend (myReverse (CDR L)) (LIST (CAR L))))
    )
)

(defun myreverse2 (l)
    (cond
        ((null l) nil)
        (t (myAppend (myReverse2 (cdr L)) (LIST (car L))))
    )
)

(defun reverseall (l)
    (cond
        ((atom l) (list l))
        (t (mapcan #'reverseall (myreverse2 l)))
    )
)


; ----- Calculate the sum of numerical atoms at any level in a nonliniar list ----- 
; Mathematical Model
; suma(l1..ln) = {
; l, if l is numeric atom
; 0, if l is atom
; suma(l1) + suma(l2..ln), if l1 is a list
; l1 + suma(l2..ln), if l1 is a atom
(defun suma (l)
    (cond
        ((numberp l) l)
        ((atom l) 0)
        ((listp (car l)) (+ (suma (car l)) (suma (cdr l))))
    )
)


; ---- Double the numerical values at any level of a nonlinear list
; Mathematical Model
; dublare(l1..ln) = 
;   { dublare(l1), if l1 is a list
;   { 2 * l1, if l1 is a number
;   { l1, if l1 atom
;   { [], otherwise
(defun dublare (l)
    (cond
        ( (null l) nil)
        ( (listp (car l)) (cons (dublare (car l)) (dublare (cdr l)) ))
        ( (numberp (car l)) (cons (* 2 (car l)) (dublare (cdr l)) ))
        ( (atom (car l)) (cons (car l) (dublare (cdr l)) ))
    )
)

;-------- Version 2 of dublare -> more compact
; Mathematical Model
; dublare2(l) =
;   { 2 * l, if l is number
;   { l, if l is atom
;   { dublare2(l1) U dublare2(l2..ln), if l is a list}
(defun dublare2 (l)
    (cond
        ((numberp l) (* 2 l))
        ((atom l) l)
        (t (cons (dublare2 (car l)) (dublare2 (cdr l)) ))
    )
)

; Merge 2 ascending lists without keeping doublicates
; Mathematical Model
; mymerge(l1..ln, k1..km) = 
;       l1..ln, if m = 0
;       k1..km, if n = 0
;       l1 U mymerge(l2..ln, k1..km), if l1 < k1
;       k1 U mymerge(l1..ln, k2..km), if l1 > k1;
;       k1 U mymerge(l2..ln, k2..km), if l1 = k1;
(defun mymerge (l k)
    ((lambda (l1 l2 k1 k2)
    (cond
        ((null l) k)
        ((null k) l)
        ((< l1 k1) (cons l1  (mymerge l2 k) ))
        ((> l1 k1) (cons k1  (mymerge l k2 )))
        (t (cons l1  (mymerge l2 k2) ))
    ))
    (car l) (cdr l) (car k) (cdr k))
)

(defun mymerge2 (l k)
    ((lambda (h1 t1 h2 t2)
        (cond
            ((null l) k)
            ((null k) l)
            ((< h1 h2) (cons h1 (mymerge2 t1 k)))
            (t (cons h2 (mymerge2 l t2)))
        ))
    (car l) (cdr l) (car k) (cdr k))
)

; ----------------------------------------------------------------
; Define a funtion to remove all occurences of an element from a nonlinear list

; Mathematical model
; removeall(l1..ln, e) =
;       { [], if n = 0
;       { removeall(l1, e) U removeall(l2..ln, e), if l1 is a list
;       { removeall(l2..ln, e), if l1 = e
;       { l1 U removeall(l2..ln, e), otherwise
(defun removeall (l e)
    ((lambda (h tl)
        (cond
            ((null l) nil)
            ((listp h) (cons (removeall h e) (removeall tl e) ))
            ((equal h e) (removeall tl e))
            (t (cons h (removeall tl e)))
        )
    ) (car l) (cdr l))
)


; ----------------------------------------------------------------
; Define a funtion to return the positions of the minimum element

(defun mymin (l m)
    (cond 
        ( (null l) m)
        ( (< (car l) m) (mymin (cdr l) (car l) ))
        ( t             (mymin (cdr l) m))
    )
)

(defun mainmymin (l)
    (mymin (cdr l) (car l))
)

; Mathematical model
; minpos(l1..ln, m, p, s) = 
;       { s, if n = 0
;       { minpos(l2..ln, m, p + 1, s U p), if l1 = m
;       { minpos(l2..ln, l2, p + 1, [p]), if l1 < m
;       { minpos(l2..ln, m, p + 1, s)
;       { 
(defun minpos (l m p s)
    (cond
        ( (null l) s )
        ( (= m (car l))   (minpos (cdr l) m (+ p 1) (cons p s)) )
        ( (< (car l) m)   (minpos (cdr l) (car l) (+ p 1) (list p)) )
        ( t               (minpos (cdr l) m (+ p 1) s))
    )
)

; mainMinpos(l1..ln) = minpos(l1..ln, min(l1..ln), 1, nil)
(defun mainminpos (l)
    (minpos l (car l) 1 nil)
)

;----------------- Lecture 9 exs ----------------- 

; inorder(l1l2l3) = (l1 - the root, l2 - the left subtree, l3 - the right subtree)
;       = nil, if l is empty
;       = (inorder(l2) U l1) U inorder(l3)
(defun inorder (l)
    (cond
        ((null l) nil)
        (t (myappend (myappend (inorder (cadr l)) (list (car l))) (inorder (caddr l)))) ; it is needed (list (car l)) because (car l) is an atom, and not list of inorder calls because they return a list
    )
)

(DEFUN MYOR (L) ; returns T if the argument is a list in which the t is
    (COND ; at least one item is evaluated at NIL
        ((null l) nil)
        ;((ATOM L) T)
        ((CAR L) T)
        (T (MYOR (CDR L)))
    )
)

;----------------- Lecture 10 exs ----------------- 
(defun double (l)
    (cond
        ((numberp l) (* 2 l))
        ((atom l) l)
        (t (mapcar #'double l))
    )
)

(defun lgm (l)
    (cond 
        ((atom l ) 0)
        (t (max (length l) (apply #'max (mapcar #'lgm l))))
    )
)

(defun attrib (varlist vallist)
    (mapc #'set varlist vallist)
)

;------------------------------------------ Lecture 11 exs ------------------------------------------
(defun lg (l)
    (cond
        ((atom l) 1)
        (t (apply #'+ (mapcar 'lg l)))
    )
)

; number of sublists with even length
(defun even (l)
    (cond 
        ((= 0 (mod (length l) 2)) t)
        (t nil)
    )
)


; Mathematical model
; nr(l) = 
;       { 0, l is atom
;       { 1 + sum(nr(l1..ln)), l = (l1..ln) if length of l is even
;       { sum(nr(l1..ln))   
;       {

(defun nr (l)
    (cond
        ((atom l) 0)
        ((even l) (+ 1 (apply #'+ (mapcar #'nr l))))
        (t        (apply #'+ (mapcar #'nr l)))
    )   
)

; Mathmatical model 
; nrap(e l) = 
;       { 1, l = e
;       { 0, l is atom
;       { sum(nrap(e, li)), altfel l = (l1..ln)
(defun nrap (e l)
    (cond
        ((equal l e) 1)
        ((atom l) 0)
        (t (apply #'+ (mapcar #'(lambda (l) (nrap e l)) l)))
    )
)

;------------------------------------------ Seminar 6 exs ------------------------------------------

; define a function that triples all the numbers in a nonlinear list

; triple(l) = 
;       { 3 * l, if l is a number
;       { l, if l atom
;       { U triple(li), i=1,n
(defun triple (l)
    (cond
        ((numberp l) (* 3 l))
        ((atom l) l)
        (t (mapcar #'triple l))
    )
)

; the product of all numerical elements
; prod(e) = 
;       { e, if e numeric
;       { 1, if e atom
;       { * prod(ei), i = 1,n
(defun prod (e)
    (cond 
        ((numberp e) e)
        ((atom e) 1)
        (t (apply #'* (mapcar #'prod e)))
    )
)

; the number of nodes from the even levels
; countEven(tree, level) =
;       { 1, tree atom & level % 2 == 0
;       { 0, tree atom
;       { + countEven(ti, level + 1), i = 1,n

(defun countEven (tree level)
    (cond
        ((and (atom tree) (= 0 (mod level 2))) 1)
        ((atom tree) 0)
        (t (apply #'+ (mapcar #'(lambda (ti) (counteven ti (+ 1 level))) tree)))
    )
)

; mainCE(tree) = countEven(tree, 0)
(Defun mainCE (tree)
    (counteven tree 0)
)

(DEFUN MYOR (L) ; returns T if the argument is a list in which the
    (COND ; at least one item is evaluated at NIL
        ((null l) nil)
        ;((ATOM L) T)
        ((CAR L) T)
        (T (MYOR (CDR L)))
    )
)

(defun myand (l)
    (cond
        ((null l) t)
        ((not (car l)) nil)
        (t (myand (cdr l)))
    )
)

; trans(l) = 
;       { [l], if number
;       { [], if atom
;       { U trans(li), i = 1,n

(defun trans (e)
    (cond
        ((numberp e) (list e))
        ((atom e) nil)
        (t (mapcan 'trans e))
    )
)

; check(l) - true if first number is 5
; check(e) = 
;       { true, if e = 5
;       { false, if e is number
;       { and check(li), i = 1,n if l1 is list
(defun check (e)
    (equal 5 (car (trans e)))
)

; countLists(e) = 
;       {   0, l atom
;       { 1 + sum(countLists(li)), i = 1,n is l is list and check
;       { sum(countLists(li)), i = 1,n is l is list and not check
(defun countlists (l)
    (cond
        ((atom l) 0)
        ((check l) (+ 1 (apply #'+ (mapcar 'countlists l))))
        (t         (apply #'+ (mapcar 'countlists l)))
    )
)

;------------------------------------------ LECTURE 12 exs ------------------------------------------

(defun suma1 (x &optional other)
    (cond
        ((null other) x)
        (t (+ x (print (apply #'+ other))))
    )
)

; Mathematical model
; myAppend(l1..ln, b1..bm) = {
;   b1..bm, if n = 0
;   l1 U myAppend(l2..ln, b1..bm), otherwize
(defun myAppend (list1 &optional list2)
    (cond
        ((null list2) list1)
        ((null list1) list2)
        (t (cons (car list1) (myAppend (cdr list1) list2)))
    )
)

; <------------- Mathematical Model ------------->
; myAppendAll(l, other) = 
;       { l, other is empty
;       { myAppendAll(other(i)), i = 1,n if l si empty
;       { myappend([l], myAppendAll(other(i))), i = 1,n if l atom
;       { myappend(l, myAppendAll(other(i)))


(defun myAppendAll (l &rest other)
    (cond
        ((null  other) l)
        ((null l) (apply #'myAppendAll other))
        ((atom l) (myappend (list l) (apply #'myAppendAll other)))
        (t (myappend l (apply #'myAppendAll other)))
    )
)

(defmacro inc (n)
    `(setf ,n (+ 1 ,n))
)

;------------------------------------------ SEMINAR 7 exs ------------------------------------------

; 1.Write a lisp function to compute the depth of a tree
; <------------- Mathematical Model ------------->
; maxn(e, other) =
;       { e, if other is nil
;       { e, if e > maxn(other)
;       { maxn(other), otherwise
(defun maxn (e &rest other)
    (cond
        ((null other) e) ; if there is only one number then this is the max
        ((> e (apply #'maxn other)) e)
        (t (apply #'maxn other))
    )
)

; <------------- Mathematical Model ------------->
; depthTree(t)
;       { 0, t empty
;       { 1 + maxn(depthTree(t(i))), i = 1,n t = (t1..tn)

(Defun depthTree (tree)
    (cond
        ((null tree) 0)
        ((atom tree) 0)
        (t (+ 1 (apply #'max (mapcar #'depthTree tree))))
    )
)

; 2. Write a function to remove all elements multiple of n from a nonlinear list

; <------------- Mathematical Model ------------->
; removeMultiple(e, n) =
;       { nil, e % n = 0
;       { [e], e atom
;       { [append(removeMultiple(ei, n))], i = 1,n e is list
(defun removeMultiple (e n)
    (cond
        ((and (numberp e) (= 0 (mod e n))) nil)
        ((atom e) (list e))
        (t (list (apply #'myappendall (mapcar #'(lambda (e) (removemultiple e n)) e))))
    )
)
