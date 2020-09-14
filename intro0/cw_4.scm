;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname CW#4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define AreaofTriangle
  (lambda (b h )
    ( / (* b h ) 2 )
   )
 )




(define AreaofSquare
  (lambda (s)
    (expt s 2 )
   )
  )


(define AreaofRectangle
  (lambda ( b h )
   (* b h )
  )
 )




(define AreaofTrapezoid
 (lambda (s1 s2 h )
   (* (/ (+ s1 s2 ) 2 ) h )
  )
 ) 


