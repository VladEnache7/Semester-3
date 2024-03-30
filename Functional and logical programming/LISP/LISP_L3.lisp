

; <-------------------------------------------------------------------------------------------------------------->
;1. Write a function to check if an atom is member of a list (the list is non-liniar)

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
; isMember(e, l) =
;       { true, e = l
;       { false, e != l
;       { myor (isMember(e, li)), i = 1,n l = (l1..ln)
(Defun ismember (e l)
    (cond
        ((equal e l) t)()
        ((atom l) nil)
        (t (myor (mapcar #'(lambda (l) (ismember e l)) l)))
    )
)

; <-------------------------------------------------------------------------------------------------------------->
; 2. Write a function that returns the sum of numeric atoms in a list, at any level.

; <------------- Mathematical Model ------------->
; sumNumbers(e) = 
;       { e, if e number
;       { 0, if e atom
;       { + (sumNumbers(ei)), i = 1,n if e = (e1..en)
(defun sumNumbers(e)
    (cond
        ((numberp e) e)
        ((atom e) 0)
        (t (apply #'+ (mapcar #'sumNumbers e)))
    )
)


; <-------------------------------------------------------------------------------------------------------------->
; 3. Define a function to tests the membership of a node in a n-tree represented as (root 
;list_of_nodes_subtree1 ... list_of_nodes_subtreen) 
;Eg. tree is (a (b (c)) (d) (E (f))) and the node is "b" => true

;(ismember node tree)



; <-------------------------------------------------------------------------------------------------------------->
;4. Write a function that returns the product of numeric atoms in a list, at any level.

; <------------- Mathematical Model ------------->
; prodNumbers(e) = 
;       { e, if e number
;       { 0, if e atom
;       { * (prodNumbers(ei)), i = 1,n if e = (e1..en)
(defun prodNumbers(e)
    (cond
        ((numberp e) e)
        ((atom e) 1)
        (t (apply #'* (mapcar #'prodNumbers e)))
    )
)


; <-------------------------------------------------------------------------------------------------------------->
;6. Write a function that returns the maximum of numeric atoms in a list, at any level.


; <------------- Mathematical Model ------------->
; maxNumbers(e) =
;       { e, if e number
;       { 0, if e atom
;       { maxNumbers(ei), i = 1,n if e = (e1..en)
(defun maxNumbers(e)
    (cond
        ((numberp e) e)
        ((atom e) (- 1000000))
        (t (apply #'maxn (mapcar #'maxNumbers e)))
    )
)

; <-------------------------------------------------------------------------------------------------------------->
;7. Write a function that substitutes an element E with all elements of a list L1 at all levels of a given list L.

; <------------- Mathematical Model ------------->
; myAppend(l1..ln, b1..bm) = 
;       { b1..bm, if n = 0
;       { l1 U myAppend(l2..ln, b1..bm), otherwize
(defun myAppend (list1 list2)
    (cond
        ((null list1) list2)
        (t (cons (car list1) (myAppend (cdr list1) list2)))
    )
)

; <------------- Mathematical Model ------------->
; myAppendAll (l, other) = 
;       { l, if other is null
;       { myAppendAll(other), if l is null
;       { [l] U myAppendAll(other), l is atom 
;       { l U myAppendAll(other), l is list 

(defun myAppendAll (l &rest other)
    (cond
        ((null  other) l)
        ((null l) (apply #'myAppendAll other))
        ((atom l) (myappend (list l) (apply #'myAppendAll other)))
        (t (myappend l (apply #'myAppendAll other)))
    )
)

; <------------- Mathematical Model ------------->
; subs(e, l1, l) =
;       { nil, l is null
;       { l1, e = l
;       { e, e != l
;       { U subs(e, l1, li), i = 1,n l = (l1..ln)
;       {
(defun subs (e l1 l)
    (cond
        ((null l) nil)
        ((equal e l) l1)
        ((atom l)  (list l))
        (t (list (apply #'myAppendAll (mapcar #'(lambda (l) (subs e l1 l)) l))))
    )
)

; <------------- Mathematical Model ------------->
; subs(e, list, l) =
;       { list, e = l
;       { e, e != l
;       { U subs(e, list, li), i = 1,n l = (l1..ln)
;       {

(defun subsMain (e list l)
    (car (subs e list l))
)


; <-------------------------------------------------------------------------------------------------------------->

;8. Write a function to determine the number of nodes on the level k from a n-tree represented as follows: 
;(root list_nodes_subtree1 ... list_nodes_subtreen) 
;Eg: tree is (a (b (c)) (d) (e (f))) and k=1 => 3 nodes

; <------------- Mathematical Model ------------->
; nrNodes(tree, k) =
;       { 0, tree is nil
;       { 1, k = 0
;       { + (nrNodes(li, k-1)), i = 1,n tree = (l1..ln)
(defun nrNodes (tree k)
    (cond
        ((null tree) 0)
        ((= k 0) 1)
        (t (apply #'+ (mapcar #'(lambda (l) (nrNodes l (- k 1))) (cdr tree)))) ; we don't count the root
    )
)

; <-------------------------------------------------------------------------------------------------------------->
;9. Write a function that removes all occurrences of an atom from any level of a list.

; <------------- Mathematical Model ------------->
; removeAll(e, l) = 
;       { nil, e = l
;       { l, e != l
;       { U removeAll(li), i = 1,n l = (l1..ln)
(Defun removeAll (e l)
    (cond
        ((equal e l) nil)
        ((atom l) (list l))
        (t (list (mapcan #'(lambda (l) (removeall e l)) l)))
    )
)

(defun removeAllMain (e l)
    (car (removeall e l))
)


; <-------------------------------------------------------------------------------------------------------------->
;10. Define a function that replaces one node with another one in a n-tree represented as: root list_of_nodes_subtree1... list_of_nodes_subtreen)

; <------------- Mathematical Model ------------->
; replaceNodes(tree, n1, n2) =\
;       { [], if tree is null
;       { n2, tree = n1
;       { tree, if tree atom
;       { myappendAll(replaceNodes(tree(i), n1, n2)), i = 1,n if tree list
(defun replaceNodes (tree n1 n2)
    (cond
        ((null tree) nil)
        ((equal n1 tree) n2)
        ((Atom tree) tree)
        (t  (mapcar #'(lambda (tree) (replacenodes tree n1 n2)) tree))
    )
)

; <-------------------------------------------------------------------------------------------------------------->
; 11.Write a lisp function to compute the depth of a tree/list
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


; <-------------------------------------------------------------------------------------------------------------->
;14. Write a function that returns the number of atoms in a list, at any level.

; <------------- Mathematical Model ------------->
; numberAtoms(e) = 
;       { 0, if e is null
;       { 1, if e is atom
;       { sum(e(i)), i = 1, n e is list
;       {
(defun numberAtoms (e)
    (cond
        ((null e) 0)
        ((atom e) 1)
        (t (apply #'+ (mapcar #'numberatoms e)))
    )
)


; <-------------------------------------------------------------------------------------------------------------->
;15. 15. Write a function that reverses a list together with all its sublists elements, at any level.

; Mathematical model
; myReverse(l1..ln) = {
;	    { [], n = 0
;	    { myReverse(l2..ln) U myReverse(l1), l1 is list
;	    { myReverse(l2..ln) U l1, otherwise

; <------------- Mathematical Model ------------->
; reverseAll(e)
;       { [], if e is null
;       { e, if e is atom
;       { myappendAll(reverseAll(e(i))) U myappendAll(reverseAll(e1(i))
;       { myappendAll(reverseAll(e(i))) U e1, i = 2, n
(defun reverseAll (e)
    (cond
        ((null e) nil)
        ((null (caddr e)))
        ((Atom e) e)
        (t (myappendall (mapcar #'reverseall e) (reverseAll e)))
    )
)

; <------------- Mathematical Model ------------->
; reverseAll(e, other)
;       { [], if e is null
;       { e, if e is atom
;       { 
;       { 