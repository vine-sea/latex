(defun n_sch( p / n_li n_lip n_liw n_lig n_all n_now)
        (setq n_li '(6 8 10 15 20 25 32 40 50 65 80 90 100 125 150 200 250 300)
                n_li2 '("1/8" "1/4" "3/8" "1/2" "3/4" "1" "1 1/4" "1 1/2" "2" "2 1/2" "3" "3 1/2" "4" "5" "6" "8" "10" "12" )
                n_lip '(10.5 13.8 17.3 21.7 27.2 34 42.7 48.6 60.5 76.3 89.1 101.6 114.3 139.8 165.2 216.3 267.4 318.5)
                n_liw '(1.7 2.2 2.3 2.8 2.9 3.4 3.6 3.7 3.9 5.2 5.5 5.7 6.0 6.6 7.1 8.2 9.3 10.3)
                n_lig '(0.369 0.629 0.851 1.31 1.74 2.57 3.47 4.10 5.44 9.12 11.3 13.5 16 21.7 27.7 42.1 59.2 78.3)
                n_all  (if (=  (type 6) (type p)) 
                    (mapcar 'n_join5 n_li n_li2 n_lip n_liw n_lig) 
                    (mapcar 'n_join5 n_li2 n_li n_lip n_liw n_lig)
                ) 
                n_now (car (n_gd10ex n_all (list p)))
                p0 (gp)
        ) 

        (vl-cmdf "circle" p0  (/ (nth 2 n_now) 2) )
        (vl-cmdf "circle" p0  (- (/ (nth 2 n_now) 2)  (nth 3 n_now) )   )

        n_now
)


(defun n_gd10ex( k p )

    (setq  elist (vl-remove-if-not
                '(lambda (pair)
                    (member (car pair)
                            ;; (list 10 42)
                            p
                    ) 
                )
                k
                )
    )

    ;; (mapcar 'n_gdd elist)
    elist
)