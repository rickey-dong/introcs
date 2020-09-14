;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname HW#12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Period 9
;;2019-9-26
;;HW#12

(define (Sequence n)
  (if (< n 2)
      1
      (begin
        (+ (Sequence (- n 1)) 3) )))
(Sequence 4)

;Challenge
(define (AddThree n a)
  (if (= n 0)
      (newline)
      (begin
        (display a) (display ",")
        (AddThree (- n 1) (+ a 3) ) )))
(AddThree 3 1) 