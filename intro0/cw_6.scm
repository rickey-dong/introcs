;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname CW#6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Annual Intro to CS Period 9
;;Mr.Dyrland-Weaver
;;2019-9-13
;;CW#6

;Task1
(define ConvertGrade
  (lambda (g)
    (if (> g 100)
        (display "invalid")
    (if (>= g 90)
        (display "A")
    (if (>= g 80)
        (display "B")
    (if (>= g 70)
        (display "C")
    (if (>= g 65)
        (display "D")
    (if (>= g 0)
        (display "F")
        (display "invalid") 
    )           
    )
    )
    )
    )
    )
    )
  )

(ConvertGrade 90)
(ConvertGrade 55)



;Task2
(define BankNote
  (lambda (m)
    (if (= m 1)
        (display "George Washington")
    (if (= m 2)
        (display "Thomas Jefferson")
    (if (= m 5)
        (display "Abraham Lincoln")
    (if (= m 10)
        (display "Alexander Hamilton")
    (if (= m 20)
        (display "Andrew Jackson")
    (if (= m 50)
        (display "Ulysses S. Grant")
    (if (= m 100)
        (display "Benjamin Franklin")
        (display "No such Banknote")
    )
    )
    )
    )
    )
    )
    )
    )
  )

(BankNote 10)
(BankNote 15) 
    
                