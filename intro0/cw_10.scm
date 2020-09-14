;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname CW#10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;CW#10
;Task 1
(define (AreaCircle r)
  (* pi (sqr r))
  )

(define ShadedArea
  (lambda (r1 r2)
    (abs (- (AreaCircle r2) (AreaCircle r1) ))
    )
  )
;Reflection: The helper function method evokes more confidence because using a helper function limits the need to have to type out multiple copies of the same thing again, making it more efficient and less prone to errors.


;Task 2
;Pseudocode for Single Definition
;1. Input r, t, and l for radius of inner circle, thickness of wall, and length
;2. Use the formula 2*pi*r*l + 2*pi(r+t) * l + 2(sqr(pi (r+t))) - pi * sqr r

;Pseudocode for Several Function Definitions
;1. Define helper function for circumference of inner circle
;2. Define helper function for circumference of whole pipe
;3. Define helper function for area of circle
;4. Use the same formula but replaced with helper functions
