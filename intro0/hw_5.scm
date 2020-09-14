;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HW#5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Rickey Dong
;;Annual Intro to CS Period 9
;;Mr. Dyrland-Weaver
;;2019-9-12
;;HW#5

(define HarMean3abc
  (lambda (a b c)
    (/ 1 (/ (+ (/ 1 a) (/ 1 b) (/ 1 c) ) 3) )
    )
  )

(HarMean3abc 5 5 5)
(HarMean3abc 3 6 18)
(HarMean3abc 5 -10 20) 