;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname CW#3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define AreaCircle
  (lambda (r)
    (* pi (expt r 2) )
    )
  )
(AreaCircle 4 )

(define CircumferenceCircle
  (lambda (d)
    (* pi d)
    )
  )
(CircumferenceCircle 4) 
