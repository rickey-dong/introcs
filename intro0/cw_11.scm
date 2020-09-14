;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname CW#11) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;Rickey Dong
;Annual Intro to CS Period 9
;2019-9-24
;CW#11

;Do Now
(remainder 312 27)

;Task 1
(define (Cookies c)
  (if (= c 0)
      (display "Do you have more cookies, I am still hungry!")
      (begin
        (sleep .6)
        (display "Munch Munch Yum Yum Cookie Number ")
        (display c)
        (newline)
        (Cookies (- c 1)))))

(Cookies 6) 


