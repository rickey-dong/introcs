;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname CW#7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;;Rickey Dong
;;Annual Intro to CS Period 9
;;Mr. Dyrland-Weaver
;;2019-9-16
;;CW#7

;DO NOW
(define ReportCard
  (lambda (mp1 mp2 mp3 mp4)
    (if (>= mp1 65)
        (display "Pass\n")
        (display "Fail\n") 
    (if (>= mp2 65)
        (display "Pass\n")
        (display "Fail\n")
    (if (>= mp3 65)
        (display "Pass\n")
        (display "Fail\n")
    (if (>= mp4 65)
        (display "Pass\n")
        (display "Fail\n")
        )))))) 
    

(ReportCard 80 81 82 83)
(ReportCard 64 62 59 49)


;Task1
(define ConvertGrade
  (lambda (g)
    (cond
      ((> g 89) "A")
      ((> g 79) "B")
      ((> g 69) "C")
      ((> g 64) "D")
      (else "F")) 
     )
   )


(ConvertGrade 90)
(ConvertGrade 55) 
      