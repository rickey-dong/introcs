;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname HW#10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Annual Intro to CS Period 9
;;2019-9-24
;;HW#10

;Single Definition
(define area-pipe
  (lambda (r t l)
    (+ (* (+ (*(* 2 pi r) l) (* pi 2 (+ r t) ) ) l) (- (* 2 (* pi (sqr (+ r t) ) ) ) (* pi (sqr r) ) ) )
    )
  )
(area-pipe 2 3 4)

;Several Function Definitions
(define (SurfaceAreaofCylinders R1 T1 L1)
  (+ (* (* 2 pi R1) L1) (* (* 2 pi (+ R1 T1) ) L1) ) )
(define (AreaofCircularEnds R2 T2)
  (* 2 (sqr (* pi (+ R2 T2) ) ) ) )
(define (AreaofOpenHoles R3)
  (* 2 (* pi (sqr R3) ) ) )
(define Area-Pipe
  (lambda (R T L)
    (- (+ (SurfaceAreaofCylinders R T L) (AreaofCircularEnds R T) ) (AreaofOpenHoles R))
    )
  )
(Area-Pipe 2 3 4) 