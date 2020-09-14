;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HW#3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define AreaofRing
  (lambda (r1 r2)
    ( - (* pi(expt (max r1 r2) 2 ) ) (* pi(expt (min r1 r2) 2 ) ) )
   )
  )
 