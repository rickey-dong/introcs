;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname CW#13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Period 9
;;2019-9-26
;;CW#13

;Do Now
;Take two minutes to think about the trace tree for the Fibonacci sequence

;Task 1
(define (Square n a)
  (if (= n 0)
      (display "STOP")
      (begin
        (display (sqr a)) (display ", ")
        (Square (- n 1) (+ a 1) ))))
(Square 4 1)

;Task 2
;Flowchart
;1.START with (approxRad2 n) --> is n=1? ----> (true) Output 1
;                                    |
;                                    |(false)
;                                    V
;                                  (1/a(n-1)) + (a(n-1))/2 

