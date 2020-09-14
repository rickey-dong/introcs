;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname HW#14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Mr. DW
;;2019-10-2
;;Period 9
;;HW#14

(define (Hanoi n s t d)
  (if (< n 0)
      (newline)
      (begin
        (Hanoi (- n 1) s t d ) (display "move from") (display s) (display "to") (display t)
        (Hanoi n s t d) (display "move from") (display s) (display "to") (display d)
        (Hanoi (- n 1) s t d) (display "move from") (display t) (display "to") (display s)
        (Hanoi (- n 1) s t d))))
(Hanoi 3 1 2 3) 

  