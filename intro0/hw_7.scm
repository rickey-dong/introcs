;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname HW#7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Annual Intro to CS Period 9
;;Mr. Dyrland-Weaver
;;2019-9-17
;;HW#7

(define quadSolve
  (lambda (a b c)
    (if (< (- (sqr b) (* 4 a c) ) 0)
        (display "no real roots\n")
    (if (= (- (sqr b) (* 4 a c) ) 0)
        (/ (* -1 b) (* 2 a) )
    (if (> (- (sqr b) (* 4 a c) ) 0)
        (begin
          (/ (+ (* -1 b) (sqrt (- (sqr (b)) (* 4 a c) ) ) ) * 2 a)
          (/ (- (* -1 b) (sqrt (- (sqr (b)) (* 4 a c) ) ) ) * 2 a)
        )
        (display "Error")
    ) 
    )
    )
   )
  )

(quadSolve 1 1 4)
(quadSolve 1 4 4) 