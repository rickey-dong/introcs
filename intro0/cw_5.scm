;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname CW#5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Rickey Dong
;;Annual Intro to CS Period 9
;;Mr. Dyrland-Weaver
;;CW#5
;;2019-9-12

;Task1
(define isPythTriple?
  (lambda (a b c)
    (if (= (+ (sqr a) (sqr b) ) (sqr c) )
           true
           false
     )
   )
 )

(isPythTriple? 3 4 5)
(isPythTriple? 3 4 6)
(isPythTriple? 65 72 97)





;Task2 Challenge
(define IsPythTriple?
  (lambda (a b c)
    (if (or (= (+ (sqr a) (sqr b) ) (sqr c) ) (= (+ (sqr a) (sqr c) ) (sqr b) ) (= (+ (sqr b) (sqr c) ) (sqr a) ) )
            true
            false
      )
    )
  ) 
       
(IsPythTriple? 5 4 3)
(IsPythTriple? 3 4 6)
(IsPythTriple? 97 72 65)









     