;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname HW#6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Annual Intro to CS Period 9
;;Mr. Dyrland-Weaver
;;2019-9-15
;;HW#6

(define TriangleType
  (lambda (a b c)
    (if (and (= a b) (= b c))  
        (display "Equilateral\n")
    (if (or (= a b) (= a c) (= b c) ) 
        (display "Isosceles\n")
        (display "Scalene\n")
    )
    )
   )
 )

(TriangleType 3 3 2)
(TriangleType 3 3 3)
(TriangleType 3 4 5)
        