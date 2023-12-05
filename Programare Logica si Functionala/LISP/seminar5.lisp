; minpos -> returns the position of the minimum element in a list
; minpos (l1..ln, mini, pos, i) = pos, if n = 0
;                         = 
(defun minpos (lst mini pos i)
    (cond
        ((null lst) pos)
        ( (not (numberp (car lst))) (minpos (cdr lst) mini pos (+ i 1)))
        ((not (numberp mini)) (minpos (cdr lst) (car lst) (list i) (+ i 1)))
        ((= (car lst) mini) (minpos (cdr lst) mini (append pos (list i)) (+ i 1)))
        ((> (car lst) mini) (minpos (cdr lst) mini pos (+ i 1)))
        ((< (car lst) mini) (minpos (cdr lst) (car lst) (list i) (+ i 1)))
    )
)

; function minposCaller -> wrapper for minpos
(defun minPosCaller (lst)
    (minpos lst nil nil 0)
)