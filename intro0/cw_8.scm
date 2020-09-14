;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname CW#8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Annual Intro to CS Period 9
;;Mr. Dyrland-Weaver
;;2019-9-17
;;CW#8

;Do Now
(define three
  (lambda (w)
    (cond
      ((< w 0) (display "-1\n"))
      ((<= 0 w 4) (display "3.5\n")) 
      (else (display "7\n") )
    )
  )
)

(three -3)
(three 2)
(three 85)


;CW#8
(define isLeapYr?
  (lambda (year)
    (cond
      ((= (remainder year 400) 0) (display "true\n"))
      ((= (remainder year 100) 0) (display "false\n"))
      ((= (remainder year 4) 0) (display "true\n"))
      (else (display "false\n") ) )))

(isLeapYr? 2000)
(isLeapYr? 2004)
(isLeapYr? 2008) 
(isLeapYr? 2009) 
(isLeapYr? 2100)
(isLeapYr? 2104)
(isLeapYr? 2200)
(isLeapYr? 2300) 
(isLeapYr? 2400)