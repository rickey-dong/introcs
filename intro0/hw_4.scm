;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname RickeyDongPd92019-9-11HW#4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Rickey Dong
;;Annual Intro to CS Period9
;;HW04 Define the Scheme Functions
;;2019-9-11
;;-----------------------------------------------------

;1.
(define CartDistX1Y1X2Y2
  (lambda (x1 y1 x2 y2)
    (sqrt (+ (sqr (- x2 x1) ) (sqr (- y2 y1) ) ) )
   )
 )
;This function should use the two pairs of coordinate points
;and find the distance between them.

(CartDistX1Y1X2Y2 0 0 3 4)
;If I input the values of 0 0 3 4 the predicted output should be 5. 

;2.
(define ArithMean3abc
  (lambda (a b c)
    (/ (+ a b c) 3) 
   )
 ) 
;This function should find the arithmetic mean between all 3 parameters.

(ArithMean3abc 1 2 3)
;If I input the values of 1 2 3 the predicted output should be 2.

;3.
(define MAX2ab
  (lambda (a b)
    (/ (+ (+ a b) (abs (- a b) ) ) 2)
   )
 )
;This function should find the greater value between a and b without
;having to use the MAX function.

(MAX2ab 9 8)
;If I input the values of 9 8 the predicted output should be 9. 