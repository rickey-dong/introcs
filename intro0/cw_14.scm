;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname CW#14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;Rickey Dong
;Mr. DW
;2019-10-2
;Period 9
;CW#14

;Non-Recursive
(define (HanoiYearsNon-Recursive n)
    (- (expt 2 n) 1) )
(define (HanoiYearsNon? n)
  (/ (HanoiYearsNon-Recursive n) (* 3600 24 365.2425) ))
(HanoiYearsNon? 27)




;Recursive
(define (HanoiYearsRecursive n)
   (if (= n 1)
      1
      (+ (expt 2 (- n 1) ) (HanoiYearsRecursive (- n 1) ))))
(define (HanoiYearsWithRecursion? n)
  (/ (HanoiYearsRecursive n) (* 3600 24 365.2425) ))
(HanoiYearsWithRecursion? 27) 