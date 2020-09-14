;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname CW#12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Period 9
;;2019-9-25
;;CW#12

;Do Now
;n!=n*(n-1)!

;Fibonacci Sequence
(define (Fib n)
  (if (<= n 2)
      1
      (+ (Fib (- n 1)) (Fib (- n 2)) ) ))
(Fib 3)
(Fib 5) 