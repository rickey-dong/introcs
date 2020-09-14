;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ResubmitHW#10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Period 9
;;2019-9-25
;;ResumbitHW#10

(define (InnerCircle r l)
  (* l (* 2 pi r) ) )
(define (Cylinder r l t)
  (* l (* 2 pi (+ r t) ) ))
(define (AreaofRing r t)
  (- (* pi (expt (+ r t) 2) ) (* pi (expt r 2) ) ) )
(define AreaPipe
  (lambda (r l t)
  (+ (InnerCircle r l) (Cylinder r l t) (* 2 (AreaofRing r t) ) ) ) ) 
(AreaPipe 2 4 3)




(define area-pipe
  (lambda (r t l)
    (+ (* l (* 2 pi r) ) (* l (* 2 pi (+ r t) ) ) (* 2 (- (* pi (expt (+ r t) 2) ) (* pi (expt r 2) ) ) ))) )
    
(area-pipe 2 3 4)