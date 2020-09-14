;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname HW#8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Annual Intro to CS Period 9
;;Mr. Dyrland-Weaver
;;2019-9-18
;;HW#8

;1.
(define daysInMonth
  (lambda (m y)
    (if (= m 1)
        (display "31\n")
    (if (= m 3)
        (display "31\n")
    (if (= m 4)
        (display "30\n")
    (if (= m 5)
        (display "31\n")
    (if (= m 6)
        (display "30\n")
    (if (= m 7)
        (display "31\n")
    (if (= m 8)
        (display "31\n")
    (if (= m 9)
        (display "30\n")
    (if (= m 10)
        (display "31\n")
    (if (= m 11)
        (display "30\n")
    (if (= m 12)
        (display "31\n")
    (if (and (= (remainder y 4) 0) (= m 2))
        (display "29\n")
        (display "28\n") ) ))))))))))))) 
   

(daysInMonth 1 2010)
(daysInMonth 2 2011)
(daysInMonth 2 2000)
(daysInMonth 4 2011) 


;Challenge
(define militarytime
  (lambda (m)
    (if (= m 0)
        (begin
          (display "12")
          (display ":")
          (display "00")
          (display "AM\n"))
    (if (= m 1)
        (begin
          (display "1")
          (display ":")
          (display "00")
          (display "AM\n"))
    (if (= m 2)
        (begin
          (display "2")
          (display ":")
          (display "00")
          (display "AM\n"))
    (if (= m 3)
        (begin
          (display "3")
          (display ":")
          (display "00")
          (display "AM\n"))
    (if (= m 4)
        (begin
          (display "4")
          (display ":")
          (display "00")
          (display "AM\n"))
    (if (= m 5)
        (begin
          (display "5")
          (display ":")
          (display "00")
          (display "AM\n"))
    (if (= m 6)
        (begin
          (display "6")
          (display ":")
          (display "00")
          (display "AM\n"))
    (if (= m 7)
        (begin
          (display "7")
          (display ":")
          (display "00")
          (display "AM\n"))
    (if (= m 8)
        (begin
          (display "8")
          (display ":")
          (display "00")
          (display "AM\n"))
    (if (= m 9)
        (begin
          (display "9")
          (display ":")
          (display "00")
          (display "AM\n"))
    (if (= m 10)
        (begin
          (display "10")
          (display ":")
          (display "00")
          (display "AM\n"))
    (if (= m 11)
        (begin
          (display "11")
          (display ":")
          (display "00")
          (display "AM\n"))
    (if (= m 12)
        (begin
          (display "12")
          (display ":")
          (display "00")
          (display "PM\n"))
    (if (= m 13)
        (begin
          (display "1")
          (display ":")
          (display "00")
          (display "PM\n"))
    (if (= m 14)
        (begin
          (display "2")
          (display ":")
          (display "00")
          (display "PM\n"))
    (if (= m 15)
        (begin
          (display "3")
          (display ":")
          (display "00")
          (display "PM\n"))
    (if (= m 16)
        (begin
          (display "4")
          (display ":")
          (display "00")
          (display "PM\n"))
    (if (= m 17)
        (begin
          (display "5")
          (display ":")
          (display "00")
          (display "PM\n"))
    (if (= m 18)
        (begin
          (display "6")
          (display ":")
          (display "00")
          (display "PM\n"))
    (if (= m 19)
        (begin
          (display "7")
          (display ":")
          (display "00")
          (display "PM\n"))
    (if (= m 20)
        (begin
          (display "8")
          (display ":")
          (display "00")
          (display "PM\n"))
    (if (= m 21)
        (begin
          (display "9")
          (display ":")
          (display "00")
          (display "PM\n"))
    (if (= m 22)
        (begin
          (display "10")
          (display ":")
          (display "00")
          (display "PM\n"))
    (if (= m 23)
        (begin
          (display "11")
          (display ":")
          (display "00")
          (display "PM\n"))
    (if (= m 2359)
        (begin
          (display "11")
          (display ":")
          (display "59")
          (display "PM") ) 
    (if (= m 24)
        (begin
          (display "12")
          (display ":")
          (display "00")
          (display "AM\n"))
        (begin
          (display "invalid input"))
      ))))))))))))))))))))))))))))
(militarytime 14)
(militarytime 16)
(militarytime 2359) 
          
      