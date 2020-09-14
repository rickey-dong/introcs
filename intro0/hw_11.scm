;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname HW#11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Period 9
;;2019-9-25
;;HW#11

(define (TimesTable a b)
  (if (> b 12)
    (display "STOP") 
    (begin
      (sleep 0.1)
      (display a)
      (display "x")
      (display b)
      (display "=")
      (display (* a b)) 
      (newline)
      (TimesTable a (+ b 1)))))
(TimesTable 6 1)



;Challenge:
(define (timestable c)
  (if (< 0 c 13)
      (display (* c (timestable (+ c 1) ) ) )
      (display "STOP") ))  
(timestable 5) 
      
