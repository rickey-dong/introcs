;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname reviewlessontest1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;Part 1
(/ (- 27 3) (* -2 -3)) ;My answer was 4. 
(/ (+ 12 9) (modulo 15 -8)) ;My answer was -21.
(define x 2)
(if (> (+ x 3) 5)
    (- x 4)
    12) ;My answer was 12.
(define fleeg 10)
(define torp 8)
(cond
  ((> fleeg (+ torp 3)) (+ fleeg torp))
  ((> fleeg torp) (- fleeg torp))
  (else (* torp fleeg))
);My answer was 2.

;Part 2 was reviewed in class

;Part 3
(define who?
  (lambda (n)
    (if (or (= 0 (remainder n 5)) (> n 100))
        (- n 6)
        (if (odd? n)
            (quotient n 10)
            (- n 40)))))
(who? 52) ;My answer was 12
(who? 150) ;My answer was 144
(who? 91) ;My answer was 9

;Part 4
(define FriendlyEnergy
  (lambda (n)
    (if (<= n 50)
        (+ (* .33 n) 15.95)
        (+ (+ (* .33 50) (* (- n 50) .27) 15.95)
    )
   )
 )
)
(FriendlyEnergy 150)

;If this were a test, I would have gotten Part 2a wrong

;Bonus Challenge
(define getOnesDigit
  (lambda (n) 
     (if (< n 10)
        n  
     (if (= n 10) 
         (display "0") 
         (remainder n 10) ) ) ) )

(getOnesDigit 125)
(getOnesDigit 51239)
(getOnesDigit 2) 
