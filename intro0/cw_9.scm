;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname CW#9b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define GetTensDigit
  (lambda (n)
    ((/(-(remainder n 100) (remainder n 10)) )) ))



(define GetNthDigit
  (lambda (a z)
    (/ (- (remainder a (expt 10 z)) (remainder a (expt 10 (- z 1)))) (expt 10 (- z 1)) )) )

(GetNthDigit 12345 3)
(GetNthDigit 34321 5) 