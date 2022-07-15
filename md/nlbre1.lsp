(defun c:nlbre1()

    (setq 
        po (gp)
        po2 (gp)
        dis (distance po po2)
        alp (/ dis 4.0)

        p1 (m_poAdd po (list 0 (- (* alp 1)) 0))
        p2 (m_poAdd po (list 0 (- (* alp 3)) 0))
        p3 (m_poAdd po (list 0 (- (* alp 4)) 0))

        buf (list 
        '(0 . "ELLIPSE")
        '(100 . "AcDbEntity") 
        '(8 . "p")
        '(100 . "AcDbEllipse") 
        ;; '(10 -8.83087e+006 7.07261e+007 0.0) 
        (append '(10) p1)
        (list 11 0.0 alp 0.0) 
        '(210 0.0 0.0 1.0)
        '(40 . 0.24) 
        '(41 . 0.0) 
        '(42 . 3.14159)
        )
        ss (ssadd)

    )
    (entmake buf)
    (ssadd (entlast) ss )


    (setq 
    newp '(210 0.0 0.0 -1.0) 
    oldp (assoc 210 buf)
    buf (subst newp oldp  buf)
    )
    (entmake buf)
    (ssadd (entlast) ss )



    (setq 
    newp (append '(10) p2)
    oldp (assoc 10 buf)
    buf (subst newp oldp  buf)
    )
    (entmake buf)
    (ssadd (entlast) ss )

    (vl-cmdf "rotate" ss ""  po "r" po  p3  po2 )

    )

    (defun m_poAdd( p1 p2 /)  (mapcar '+ p1 p2))