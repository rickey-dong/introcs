;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname CSLAB) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;Rickey Dong
;Mr. DW
;Period 9
;2019-10-1
;CSLAB

;Task 1
(define (sumoffirstNnaturalnumbers n)
  (if (= n 1)
      1
      (+ n (sumoffirstNnaturalnumbers (- n 1) ) ) ))

(sumoffirstNnaturalnumbers 10)

;Task 2
(define (OddNumsBetween a b)
  (if (> a b )
      (newline)
      (begin
        (if (= (remainder a 2) 1)
           a
           (+ a 1))
        (newline)
        (display a)
        (OddNumsBetween (+ a 2) b) )))
(OddNumsBetween 1 10)

;Task 3
(define (Seq4 n a)
  (if (= n 0)
      (newline)
      (begin
        (display a) (display ", ")
        (Seq4 (- n 1) (* 4 a) )))) 
(Seq4 3 1)

;Task 4
(define (SeqSquare n a)
  (if (= n 0)
      (newline)
      (begin
        (display a) (display ", ")
        (SeqSquare (- n 1) (sqr (+ (sqrt a) 2) )))))
(SeqSquare 3 1)

;Challenge1
(define (Sequence n)
  (if (= n 1)
      -4
      (+ (Sequence (- n 1)) n) ))
(Sequence 3)
(Sequence 5) 

;Challenge2
(define (Sequence2 n)
  (if (= n 1)
      10
      (/ (+ 2 (Sequence2 (- n 1) ) ) 2) ))
(Sequence2 3)
(Sequence2 2)