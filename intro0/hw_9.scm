;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname HW#9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Annual Intro to CS Period 9
;;Mr. Dyrland-Weaver
;;2019-9-19
;;HW#9

(define TotalDuration
  (lambda (hOne mOne sOne hTwo mTwo sTwo)
    (if (and (and (< mOne 60) (< mTwo 60) ) (and (< sOne 60) (< sTwo 60) ) )     
       (begin
        (display (quotient (+ (* (+ (* (+ hOne hTwo) 60) (+ mOne mTwo) ) 60) sOne sTwo) 3600) )
        (display ":")
        (display (quotient (remainder (+ (* (+ (* (+ hOne hTwo) 60) (+ mOne mTwo) ) 60) sOne sTwo) 3600) 60))
        (display ":")
        (display (remainder (remainder (+ (* (+ (* (+ hOne hTwo) 60) (+ mOne mTwo) ) 60) sOne sTwo) 3600) 60))
        (newline)
       )
       (display "Error")
     )
  )
)


(TotalDuration 0 32 21 0 33 20)
(TotalDuration 3 59 59 2 13 3) 