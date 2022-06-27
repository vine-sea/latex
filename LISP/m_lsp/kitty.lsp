


(setq 
    kpl "C:\\Program Files\\Autodesk\\AutoCAD 2014\\Support\\m_lsp\\"
    kpd "C:\\Program Files\\Autodesk\\AutoCAD 2014\\Support\\m_dcl\\"
    kpf "E:\\ZCM\\ALL\\"

    k_l1 0
    k_LayList nil

    std2 19


    k_c1 10
    k_c2 5
    k_c3 0
    k_c4 0
    k_c5 0
    k_c6 1
    k_c7 1
    
    k_t1  "<>"
    k_t2  "1-"
    k_t3  "(100 0 0)"
    k_t4  "( \"close\"  \"n\")"
    k_t5  ""
    k_t6  ""
    k_t7  ""

)


(defun k_Lays( / lays layName layNames )

  (setq 
      lays (TBLNEXT "LAYER" 'T)
      layName (cdr (assoc 2 lays ))
      layNames (list layName)
  )


  (while  lays
        (setq  
            lays (TBLNEXT "LAYER" ) 
            layName (cdr (assoc 2 lays ))
        )      
        (IF (/= lays NIL)
              (progn
              (setq layNames (append (list layName) layNames))
  
              )  
        )
  )

    
  layNames
      
)
(defun k_poFlag(n1 n2 / x re)
  (setq x 1
      re (list )
  )
  (repeat n2
      
  (setq 
      re (if (= x n1) (append re '(1)) (append re '(0)))                      
      x (1+ x))
  )
  re
) 
(defun k_ssl( / ss )

  (setq ss (ssget))
  (list  (ssname ss 0) (list 0 0 0))
)
(defun k_setl1( / LayList)

  (setq          
  LayList (k_Lays))
  (set_tile "k_l1" (rtos k_l1))


  (start_list "k_l1")
  (mapcar 'add_list LayList)
  (end_list)

  LayList

)
(defun k_setr( / sor tar  )


  ;; [Hide_obj Show_obj Hide_lay Show_lay Scale Load All Pu xx xx xx]
  (setq sor (list "k_r1" "k_r2" "k_r3" "k_r4" "k_r5" "k_r6" "k_r7" "k_r8" "k_r9" "k_r10" "k_r11" "k_r12" "k_r13" "k_r14" "k_r15" "k_r16" "k_r17" "k_r18" "k_r19"  "k_r20" "k_r21" "k_r22" "k_r23" "k_r24" )
      tar (mapcar 'rtos (k_poFlag std2 (length sor) ))
  )

  (mapcar 'set_tile sor tar)
  (princ )
)
(defun k_setc( / c7_s c7_t t7_s t7_t)
  (setq 
  c7_s (list "k_c1" "k_c2" "k_c3" "k_c4"  "k_c5" "k_c6" "k_c7" )
  c7_t (mapcar 'rtos (list k_c1 k_c2 k_c3 k_c4 k_c5 k_c6 k_c7 )) 
  t7_s (list "k_t1" "k_t2" "k_t3" "k_t4"  "k_t5" "k_t6" "k_t7" )
  t7_t (list k_t1 k_t2 k_t3 k_t4 k_t5 k_t6 k_t7 )

  )
  
  (mapcar 'set_tile c7_s c7_t)
  (mapcar 'set_tile t7_s t7_t)
     


)
(defun c:aa( / dlg_name dlg_file dlg_id )

  (setq   

          dlg_name   "kitty"  
          dlg_file  (strcat  kpd "kitty") 
          dlg_id (load_dialog dlg_file)
          std 1
  )



  (while (>= std 1)
      (if (not (new_dialog  dlg_name dlg_id   )) (exit))
      (k_setc)
      (k_setr)
      (setq k_LayList (k_setl1))
      (setq std (start_dialog))
      ;; (k_cond)
  )


  (unload_dialog dlg_id)
  (princ )


)



(defun k_cond()
  (cond  
    ((= std2 1) (n_Hide_obj))
    ((= std2 2) (n_Show_obj))
    ((= std2 3) (n_Hide_lay))
    ((= std2 4) (n_Show_lay))
    ((= std2 5) (n_Scale k_c1))
    ((= std2 6) (n_LoadAll))
    ((= std2 7) (n_Pu))
    ((= std2 8) (n_2w))
    ((= std2 9) (n_mlEx (ssname (ssget) 0) (/ k_c1 2) (nth (ftoi k_l1) k_LayList)))
    ((= std2 10) (n_sortLable (atoi (rtos k_c1)) k_t2))
    ((= std2 11) (n_pipe (ssname (ssget) 0) k_c1 k_c2))
    ((= std2 12) (n_2))
    ((= std2 13) (n_3))
    ((= std2 14) (n_Midli (gp) (m_poScaSC (read k_t3) 0.5)))
    ((= std2 15) (n_32 (gp) (gp)))
    ((= std2 16) (n_ca k_c6 k_c7))
    ((= std2 17) (n_q "one.txt" k_t2  k_c1) )
    ((= std2 18) (n_lineT))
    ((= std2 19) (n_d1))
    ((= std2 20) (n_d2s (if (= k_t5 "") nil T )))
    ((= std2 21) (n_brex (ssget) (ssget)))


  )
)
(defun m_poAdd( p1 p2 / )   (mapcar '+ p1 p2))
(defun m_posub( p1 p2 /)  (mapcar '- p2 p1))
(defun m_getVerA( vec / base target  )
  (cond 
        ((< (abs (car vec)) 0.00000001)
        (setq vec (list 0 (cadr vec)  0 )))
  
        ((< (abs (cadr vec)) 0.00000001)
        (setq vec (list (car vec) 0   0 )))
  
  )
  (princ vec)

  (cond ((> (cadr vec) 0)
              (if (= (car vec) 0)
              (list 1 0 0)
              (list 1 (- (/ (car vec) (cadr vec))) 0)
              )
        )
      

        ((< (cadr vec) 0)
              (if (= (car vec) 0)
              (list (- 1) 0 0)
              (list (- 1)  (+ (/ (car vec) (cadr vec))) 0 )
              )
        )


        ((and (= (cadr vec) 0) (> (car vec)0) )
        (list 0 (- 1) 0)
        
        )

        ((and (= (cadr vec) 0) (< (car vec)0) )
        (list 0 1 0)
        
        )


  
  
  )





  ;; (setq vec (m_poSwap vec))

)
(defun m_poRep(p n / buf1 buf)

  (setq 

        buf (list p)
        buf1 (list p)
  )


  (repeat (- n 1)
        (setq buf1 (append buf buf1)) 
  )

  buf1
 
)
(defun m_poScaSC( p1 sc / len alp ) (mapcar '* p1 (m_poRep sc (length p1))))
(defun m_change (p3 lay) (vl-cmdf  "change" p3 "" "p" "la"  lay  ""))
(defun m_poMo( p1 / re) (sqrt (apply '+ (mapcar 'expt p1 (m_porep 2 (length p1))))) )
(defun m_poSca( p1 sc / len alp ) (mapcar '*  p1 (m_poRep (/ sc (m_poMo p1)) (length p1)) )
)
;; atoi atof itoa  
(defun ftoi(p)(atoi (rtos p)))





;;[Hide_obj Show_obj Hide_lay Show_lay Scale Load All Pu 2w mlex sortLable ]
(defun n_Hide_obj()   (vl-cmdf "hideobjects" (ssget) "" ) )
(defun n_Show_obj()   (vl-cmdf "unIsolateObjects") )
(defun n_Hide_lay()   (vl-cmdf "layoff" (k_ssl) ""))
(defun n_Show_lay()   (vl-cmdf "layon" ))
(defun n_Scale(c1 /)  (vl-cmdf "scale" (ssget) "" (getpoint "po\n") c1))
(defun n_LoadAll()    (vl-load-all (strcat kpl "kitty.lsp") ) )
(defun n_Pu()  
  (DICTREMOVE  (NAMEDOBJDICT) "ACAD_DGNLINESTYLECOMP" )
  (command "zoom" "e")
  (vl-cmdf "purge" "a" "" "n")
)
(defun n_2w( / ss num x line_data old_spoint new_spoint new_line_data)

  ;; (setq line_data (entget (car (entsel))))
  (setq ss (ssget))
  (setq num (sslength ss))
  (setq x 0)


  (repeat num
      
        (setq line_data (entget  (ssname  ss x) ))

        (cond  ((= (cdr (assoc 0 line_data))  "DIMENSION")
        (progn
        ;; ????????
        (setq old_spoint (assoc 1 line_data))
        (setq new_spoint (cons 1 k_t1))
        (setq new_line_data (subst new_spoint old_spoint line_data))
        ;; ???Q??
        (setq old_spoint (assoc 8 new_line_data))
        (setq new_spoint (cons 8 "DIM"))
        (setq new_line_data (subst new_spoint old_spoint new_line_data))

        (entmod new_line_data)
        ))

        ((= (cdr (assoc 0 line_data))  "LEADER")
        (progn
        (setq old_spoint (assoc 8 line_data))
        (setq new_spoint (cons 8 "DIM"))
        (setq new_line_data (subst new_spoint old_spoint line_data))
        (entmod new_line_data)
        ))

        ((= (cdr (assoc 0 line_data))  "TEXT")
        (progn
        (setq old_spoint (assoc 8 line_data))
        (setq new_spoint (cons 8 "T"))
        (setq new_line_data (subst new_spoint old_spoint line_data))
        (entmod new_line_data)
        ))

        )

      
        (setq x (1+ x))
  )

  (princ)

)
(defun n_mlEx(buf dis lay / p1 p2 vec ss  )
  (setq
        ;; buf (ssname (ssget) 0) ;;(entsle)

        ;; (cdr (assoc 10 (ssname (ssget) 0)))
        ;; dis (/ k_c2 2) 
        p1  (cdr (assoc 10 (entget buf) ))
        p2  (cdr (assoc 11 (entget buf) )) 

        ss  (ssadd)
        ;; lay (nth (ftoi k_l1) k_LayList)   ;;"0"
  )

  (if (or (= p1 nil) (= p2 nil))
      (setq p1 (gp)  p2 (gp))
      (setq 
        vec (m_posub p1 p2)  ;;???_???
        vec (m_getVerA vec) 
        p1 (m_poAdd vec p1)
        p2 (m_posub vec p1)
      )
  )



  ;; (princ "here")

  (vl-cmdf  "offset" dis  buf p1 "")
  (ssadd (entlast) ss)
  (vl-cmdf  "offset" dis  buf p2 "")
  (ssadd (entlast) ss)

  (m_change ss lay)
  ;;   (if (not (= y3 0)) (vl-cmdf "ERASE" buf ""))


)
(defun n_changeLableT( p  param / a oldbuf oldAtr newAtr newbuf)
  (setq 
      ;; param "123456"
      a (entnext p)
      oldbuf (entget a)
      oldAtr (assoc 1 oldbuf)
      newAtr (cons 1 param)
      newbuf (subst newAtr oldAtr oldbuf)
      
  )
  (entmod newbuf)
)
(defun n_sortLable(  x pre / ss buf bufp )
  (setq 
        ;; x (atoi (rtos k_c1))
        ;; pre k_t2
        buf (ssname (ssget) 0)
        bufp (gp)  ;;(cdr (assoc 10 (entget buf)))
        po (gp)
  )
  
  (while po 

     
    (vl-cmdf "copy" buf  "" bufp bufp )
    (n_changeLableT (entlast) (strcat pre (itoa x)))
    (vl-cmdf "move" (entlast)  "" bufp po )
    
    
    (setq x (1+ x)
         po (gp))
  )
    
    

  
  ;; (while (setq ss  (ssname (ssget) 0))
  
  ;;   (n_changeLableT ss (strcat pre (itoa x)))
  ;;   (setq x (1+ x))
  
  ;; )
  
  
  (princ )

)
(defun n_pipe(p fi1 fi2)
  (n_mlEx p (/ fi1 2) "0")
  (n_mlEx p (- (/ fi1 2) fi2) "D")
)
(defun n_2( / mp ml)
  (setq ml (k_ssl))
  (setq mp (getpoint "point")) 
  (vl-cmdf "break"  ml "f" mp mp)
)
(defun n_3( / m1 m2 m3)

  (setq  m1 (getpoint "1\n")  
          m2 (getpoint "2\n")  
  )
  (vl-cmdf "dimlinear" m1 m2 "r" m1 m2 )

)
(defun n_Midli( base p / p1 p2 )

  (setq p1  (m_poAdd p base )
        p2  (m_posub p base )
  )

  (vl-cmdf "line" p1 p2 "")

  (list p1 p2)

)
(defun n_32( base p / )

    (setq vec (m_posub base p) 
          vec (m_poScaSC vec 1.2)
          ss (ssadd)
    )
  
    (n_Midli base vec)
    (vl-cmdf "rotate" (entlast) "" base 90)
    (ssadd (entlast) ss)
    (n_Midli base vec)
    (ssadd (entlast) ss)
    (m_change ss "C")



)
(defun n_ca( p1 p2) (* (/ p1 p2 ) (getreal )))
(defun n_q( name pre x / fileName flag flag2 fp)
    (setq 
      ;; name  "one.txt"
      ;; pre k_t2
      ;; x   k_c1
      x (ftoi x)
      fileName (strcat kpf name)
      flag 0
      fp (open fileName "a"))


    (while (and (setq p1 (gp)) (setq p2 (gp)) (setq p3 (gp)) (setq p4 (gp)))
      (vl-cmdf "dimlinear" p1 p2 "r" p1 p2  pause )
      (setq buf (entlast))
      (vl-cmdf "dimlinear" p3 p4 "r" p3 p4  pause )
      (if (findfile fileName) (princ (strcat pre (itoa x) " " (rtos (cdr (assoc 42 (entget buf)))) "x" (rtos (cdr (assoc 42 (entget (entlast))))) "\n" ) fp) )
      (vl-cmdf "erase" buf "")
      (vl-cmdf "erase" (entlast) "")
      (setq x (1+ x)
            flag 1)
    )
    
    (while (and (= 0 flag) (or flag2 (and p1 p2)))
      (vl-cmdf "dimlinear" p1 p2 "r" p1 p2  pause )
      (if (findfile fileName) (princ (strcat pre (itoa x) " " (rtos (cdr (assoc 42 (entget (entlast)))))  "\n" ) fp) )
      (vl-cmdf "erase" (entlast) "")
      (setq x (1+ x)
            flag2 (and (setq p1 (gp)) (setq p2 (gp)))
      )
    )
 
    (close fp)
   
)
(defun n_q_ex( n  buf / x flag bufs )
  (setq 
        ;; buf (n_find)
        ;; buf '(6 7 8 9 10 23 25 26)
        n (if (= nil n) (getint) n)
        x 0
        flag 0
        bufs (list ))
  (repeat (length buf)
      (if (= n (nth x buf)) (setq flag 1))
      (if (= 1 flag) (setq bufs (append bufs (list (nth x buf) ))))

      (setq x (1+ x))
  )
  (mapcar 'n_q_el bufs)
)
(defun n_q_el( x / buf  name pre p1 p2 flag fileName flag fp )
    (princ (strcat "this is " (itoa x) "   plese find " (itoa x)  "\n"))
     
    
    (setq 
      name  "one.txt"
      pre k_t2
      buf (if (not (= (getint "FIND?") nil)) (vl-cmdf "find") )
      p1 (getpoint "p1\n")
      p2 (getpoint "p2\n")
    
      fileName (strcat kpf name)
      flag 0
      fp (open fileName "a")
    )

    (if (and p1 p2)
      (progn 
        (vl-cmdf "dimlinear" p1 p2 "r" p1 p2  pause )
        (if (findfile fileName) (princ (strcat pre (itoa x) " " (rtos (cdr (assoc 42 (entget (entlast)))))  "\n" ) fp) )
        (vl-cmdf "erase" (entlast) "")
      )
      (progn 
        (if (findfile fileName) (princ (strcat pre (itoa x) " " "erro"  "\n" ) fp) )
      )
      
    )
 
  
    (close fp)
)
(defun n_find( / buf len x datas data flag)
  ;; dim txt
  (setq 
    buf (ssget)
    len (sslength buf)
    x 0
    flag k_c7
    datas (list ))
  (repeat len 
    (setq 
      ;; data (if (= 1 flag) 
      ;;       (cdr (assoc 1 (entget (ssname buf x)))) 
      ;;       (cdr (assoc 1 (entget (entnext (ssname buf x)))))  )
      data (cdr (assoc 1 (entget (entnext (ssname buf x)))))  ;;Block
      data (vl-string-trim " \t\n" data)
      data (atof (substr  data 3))
      datas (append datas (list data) )
      x (1+ x))
        ;; (princ data)
  )
  
  (mapcar 'ftoi (vl-sort (n_removelist datas) '<))
)
(defun n_lineT( / p1 p2)
  (while (and (setq p1 (gp)) (setq p2 (gp))) 
    (vl-cmdf "line" "_tan" p1 "_tan" p2 ""))
  
  ;; buf
)
(defun n_d1( / buf  p1 p2 p3 p4 ver a )

       
      (setq 
            flag k_c7
            buf (entget  (ssname (ssget) 0) )
            p1 (if (= flag 1) (cdr (assoc 13 buf)) (cdr (assoc 14 buf)) )  
            p2 (if (= flag 1) (cdr (assoc 14 buf)) (cdr (assoc 13 buf)) ) 
            p3 (cdr (assoc 10 buf))

            ;; 1.5708
            p4  (cdr (assoc 50 buf))

            ver (if (= p4 0) 
                  ;; 
                  (mapcar 'n_sign0 (m_posub p1 p2) '(1 0 1)) 
                  (if (= p4 (/ pi 2))
                    (mapcar 'n_sign0 (m_posub p1 p2) '(0 1 1)) 
                    (list (cos p4) (sin p4) 0) 
                  )
                  
                )


            ;; ver (list (cos p4) (sin p4) 0)
            ;; ver (m_posub p1 p2)  
      )
      ;; (vl-cmdf "dimlinear" p1 p2 "r" p1 p2 p3) 
       


      (setq a (getreal))

      (while (not (= a 0)) 
            (setq  
                  ver (m_poSca ver a) 
                  p1 p2
                  p2 (m_poadd p2 ver)

            )
           (vl-cmdf "dimlinear" p1 p2 "r" p1 p2 p3) 
            (setq a (getreal))
      )


)

(defun n_d2( in1 a  c / buf  p1 p2  p4 ver  flag  buf2 )

       
      (setq 
            flag 1
            buf2 (ssname in1 0)
            buf (entget  buf2 )
            p1 (if (= flag 1) (cdr (assoc 13 buf)) (cdr (assoc 14 buf)) )  
            p2 (if (= flag 1) (cdr (assoc 14 buf)) (cdr (assoc 13 buf)) ) 
            pp3 (cdr (assoc 42 buf))

            ;; 1.5708
            p4  (cdr (assoc 50 buf))

            ver (if (= p4 0) 
                  ;; 
                  (mapcar 'n_sign0 (m_posub p1 p2) '(1 0 1)) 
                  (if (= p4 (/ pi 2))
                    (mapcar 'n_sign0 (m_posub p1 p2) '(0 1 1)) 
                    (list (cos p4) (sin p4) 0) 
                  )
                  
                )
            ver (m_poSca ver a) 
            mver (m_poSca ver (/ (-  pp3 a) 2.0))
            p2 (m_poadd p1 ver)
      )

        (vl-cmdf "dimbaseline"  in1   p2 "" "")
        (if (not (= nil c )) (vl-cmdf "move" (gl) "" "D" mver))
        

)

(defun n_d2s( c / a b )
  



  (setq a (getreal))
  (n_d2 (ssget) a c)

  (while (setq a (getreal))
      (n_d2 (gl) a c)
  )
)


(defun m_po32(p)(list (car p) (cadr p)))


(defun n_sign(p / re )
  (if (= p 0)
    (setq re 0)
      (if (> p 0)
      (setq re 1)
      (setq re -1)
    )
  )
  re
)

(defun n_sign0(p n / re )
    (if (= n 0)
      (setq re 0)
      (setq re p)     
    )
    re
)


(defun n_cstyle( p1 )
  (vl-cmdf "_style" (strcat "S" (rtos p1)) "" "" "" p1 "" "" "")
  (setvar "dimtxsty" (strcat "S" (rtos p1)))
)
(defun n_cdimstyle( p1 )
  (vl-cmdf "dimscale" p1 )
  (vl-cmdf "_dimstyle" "s" (strcat "S" (rtos p1)))
)
(defun n_rdim( p1 p )
  (prompt "(-30 -30) (30 30) (-30 90) (30 90)")
  (n_cstyle p1)
  
  
  (setq  m1 (getpoint "1\n")  
        m2 (getpoint "2\n")  
  )
  (vl-cmdf "dimlinear" m1 m2 "r" m1 m2 pause )
  
  (setq ss (entlast))
  
  (if (= nil p)   (vl-cmdf "dimedit" "o"  ss ""  )
                  (vl-cmdf "dimedit" "o"  ss "" p ) )
  

  (n_cstyle 0)
)
(defun n_talx(  / flag  ss p0 x num dp p ss_data old_layer new_layer new_data)
 
      (setq 
            ss (ssget)
            flag 1
            ss_data (entget (ssname ss 0))
            p0 (cdr (assoc 10 ss_data))
            x 1
            num (1- (sslength ss) )


      )

     


      (repeat num
            (setq 
                  ss_data (entget (ssname ss x))
                    
                  p (cdr (assoc 10 ss_data))
                  dp (if (= flag 1) (car (m_posub p p0))  (cadr (m_posub p p0)))
                  p (if (= flag 1) (m_poadd p (list dp 0 0)) (m_poadd p (list 0 dp 0)))
                  old_layer (assoc 10 ss_data)
                  new_layer (append '(10) p )
                  new_data (subst new_layer old_layer ss_data)
                 


                  x (1+ x))
            (if  (= (cdr (assoc 0 ss_data)) "TEXT") (entmod new_data) )
             
      )





      (princ)

)
(defun n_cal( a  b c )
  (setq a (if (= a nil) (getreal) a) 
        b (if (= b nil) (getreal) b) 
        c (if (= c nil) (getreal) c)  
  )
  ;; 7.85?/1000^3mm^3
  (/ (* a b c 7.85) (* 1000 1000 1000))

)
(defun n_cal1( a  b c d l / v)
  (setq a (if (= a nil) (getreal) a) 
        b (if (= b nil) (getreal) b) 
        c (if (= c nil) (getreal) c)  
        d (if (= d nil) (getreal) d)
        l (if (= l nil) (getreal) l)
        v (* l (+ (* a d 2) (* b c) (* -1 2 c d)))
  )
  ;; 7.85?/1000^3mm^3
  (/ (* v 7.85) (* 1000 1000 1000))

)
(defun n_cal2( a  b  l / v)
  (setq a (if (= a nil) (getreal) a) 
        b (if (= b nil) (getreal) b) 
        l (if (= l nil) (getreal) l)
        v (* (- (* pi (/ a 2) (/ a 2)) (* pi  (- (/ a 2) b) (- (/ a 2) b) )) l)
  )
  ;; 7.85?/1000^3mm^3
  (/ (* v 7.85) (* 1000 1000 1000))

)
(defun n_SpDIM (/ sel newpt ent edata elist)   
  (if (and (setq edata (m_getData (ssget) ))
           (setq newpt (getpoint "\Select new Dim Point"))
      )
    (progn (setq  elist (vl-remove-if
                         '(lambda (pair)
                            (member (car pair)
                                    (list -1 2 5 102 310 300 330 331 340 350 360 410)
                            ) 
                          )
                         edata
                       )
           )
            ;;reinit      
           (entmod (subst (cons 14 newpt) (assoc 14 elist) edata))
            ;;create      
           (entmakex (subst (cons 13 newpt) (assoc 13 elist) elist))
    )
  )
  (princ)
)
(defun n_tadd( / buf x ss len item )
  (setq buf (ssget)
        x 0
        ss 0
        len (sslength buf)
  )

  (repeat len 
    (setq 
      item (atof (cdr (assoc 1 (entget (ssname buf x)))))
      ss (+ ss item)
      x (1+ x))
    ;; (princ (strcat (rtos ss) "  "))

  )

  ss

)
(defun n_sortLinesxy( / buf len x a b posx posy)
  (setq 
    buf (ssget)
    len (sslength buf)
    x 0
    posx (list )
    posy (list )
  )
  (repeat len 
    (setq 
      a (cdr (assoc 10 (entget (ssname buf x))))
      b (cdr (assoc 11 (entget (ssname buf x))))
      posx (append posx  (list (car a) (car b)))
      posy (append posy  (list (cadr a) (cadr b)))
      x (1+ x))
  )
  (setq posx (vl-sort posx '>)
        posy (vl-sort posy '>)  
        posx (n_removelist posx)
        posy (n_removelist posy)
  )
  (list posx posy)
)
(defun n_removelist( a / flag buf a)
  (setq 
        ;; a '(1 2 3 4 4 6 6 8 8 9)
        flag 1  
        buf (list )
  )

  (while (= flag 1)
      (setq buf (append buf (list (car a)))
            a (n_removelist_el buf a)
            flag (if (= a nil) 0 1)
      )
  )
  buf 
)
(defun n_removelist_el( a b / n)
  (foreach n a (setq b (vl-remove n b)))
  b
)

(defun n_2func( a b c / )

  ;; (princ a)
  (setq 
    delta0  (- (* b b) (* 4 a c))  
    delta   (if (>= delta0  0 ) (sqrt  delta0) 0 )
    x1      (if (>= delta0  0 ) (/ (+ (- b) delta) (* 2 a)) 0 )
    x2      (if (>= delta0  0 ) (/ (+ (- b) (- delta)) (* 2 a)) 0 )
  )

  (list ;;delta0 delta
   x1 x2)

)

(defun n_22_21func( x1 y1 r x2 y2 x3 y3 / a b c m n l k1 k2 k3 buf x1 x2 y1 y2)


  ;;(x-x1)^2+(y-y2)^2=0
  ;;(x-x2)/(y-y2)=(x2-x3)/(y2-y3)

  ;; x^2+y^2+ax+by+c=0 
  ;; mx+ny+l=0
  

  (setq 
    a (- (* 2 x1))
    b (- (* 2 y1))
    c (+ (* x1 x1) (* y1 y1) (- (* r r)))
    m 1
    n (/ (- x2 x3) (- y2 y3))
    l (- (* n y2) x2) 
 
  )


  (setq 
    k1 (+ 1 (/ (* n n) (* m m)))
    k2 (+ (* 2 n l (/ 1 (* m m))) b (- (* a n (/ 1 m))))
    k3 (+ (* l l (/ 1 (* m m))) c (- (* a l (/ 1 m))))
    buf (n_2func k1 k2 k3)
    y1 (car buf)
    y2 (cadr buf)

    x1 (- (/ (+ (* n y1) l) m))
    x2 (- (/ (+ (* n y2) l) m))

  )

  (list (list x1 y1) (list x2 y2))

)

(defun n_22_21funcEx( p1 r p2 k / 
  ;; a b c m n l
 k1 k2 k3 buf x1 x2 y1 y2)


  ;;(x-x1)^2+(y-y2)^2=0
  ;;(x-x2)/(y-y2)=(x2-x3)/(y2-y3)

  ;; x^2+y^2+ax+by+c=0 
  ;; mx+ny+l=0
  
 



  (setq 

    x1 (car p1)
    y1 (cadr p1)
    a (- (* 2 x1))
    b (- (* 2 y1))
    c (+ (* x1 x1) (* y1 y1) (- (* r r)))
    m 1
          
    n (/ 1 k) 
    l (- (+ (/ (car p2) k) (cadr p2)) ) 
 
  )


  (setq 
    k1 (+ 1 (/ (* n n) (* m m)))
    k2 (+ (* 2 n l (/ 1 (* m m))) b (- (* a n (/ 1 m))))
    k3 (+ (* l l (/ 1 (* m m))) c (- (* a l (/ 1 m))))
    buf (n_2func k1 k2 k3)
    y1 (car buf)
    y2 (cadr buf)

    x1 (- (/ (+ (* n y1) l) m))
    x2 (- (/ (+ (* n y2) l) m))

  )

  (list (list x1 y1) (list x2 y2))

)


(defun n_trimex( a b ) (vl-cmdf  "trim"  "" "c" a b ""))

(defun n_brex(ss a / )
    (setq x 0
          n (sslength ss)
          buf2 (entget (ssname a 0))
          buf2 (n_gd10ex3 buf2 '(10 11))
    )

    (repeat n
          (setq buf (entget (ssname ss x))
                buf (n_gd10ex3 buf '(10 11))
                x (1+ x)
                a (n_joinpo buf buf2)
          )

        (if (not (= nil a)) (vl-cmdf "break" (ssname ss (1- x)) "" "F"  a  a ))
    )


)
(defun n_joinpo( a b)
 (inters (nth 0 a) (nth 1 a) (nth 0 b) (nth 1 b) nil) 
)




(defun gl( / a) 
  (setq a (ssadd)
        a (ssadd (entlast)  a )  
  ) 
  (sssetfirst   nil a)
  a
)


(defun n_gd10( p )

    (setq  elist (vl-remove-if-not
                  '(lambda (pair)
                    (member (car pair)
                            ;; (list 10 42)
                            p
                    ) 
                  )
                  (gd)
                )
    )

    ;; (mapcar 'n_gdd elist)
    elist

)




(defun n_gd11( p )

    (setq  elist (vl-remove-if
                  '(lambda (pair)
                    (member (car pair)
                            ;; (list 10 42)
                            p
                    ) 
                  )
                  (gd)
                )
    )

    ;; (mapcar 'n_gdd elist)
    elist

)

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

(defun n_join5( a b c d e) (list a b c d e))





(defun n_gd10ex2( p )

    (setq  elist (vl-remove-if-not
                  '(lambda (pair)
                    (member (car pair)
                            ;; (list 10 42)
                            p
                    ) 
                  )
                  (gd)
                )
    )

    (mapcar 'n_gdd elist)
    ;; elist

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

(defun n_gd10ex3( k p )

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

    (mapcar 'n_gdd elist)
    ;; elist

)

(defun n_gdd(a)
  (cdr a)
  ;; a
)

(defun n_ang2tu( x ) (/ (sin (angtof  (rtos (/ x 4.0))) ) (cos (angtof  (rtos (/ x 4.0))) )))

(defun n_arc2poly( / p r n theta)
 
  ;; r*cos r*sin
  ;;theta

  (setq 
    p (gp)
    r 4000
    n 100
    theta 0
    delta (/ 360.0 n)
    ps (list )
  )
  




  (repeat (+ n 1)
    (setq 
      p1 (list (* r(cos (/ theta 180  (/ 1 pi)))) 
               (* r(sin (/ theta 180  (/ 1 pi)))) 0 )
      p1 (m_poAdd p1 p )
      ps (append ps (list p1))
    )




    (setq theta  (+ theta delta))
  )

   


  ;; ps
  (n_multiLine ps)

)



(defun n_multiPo( / buf a )
  (setq buf (list ))
  (while (setq a (gp))
    (setq buf (append buf (list a)) )
  )
  buf
)


(defun n_multiLine( p / buf2 )
  (setq 

    po (mapcar 'append  (mapcar 'list (m_poRep 10 (length p) )) p)
    buf2 (list '(0 . "LWPOLYLINE") '(100 . "AcDbEntity") '(8 . "0") '(100 . "AcDbPolyline") (cons 90  (length p) ) )

    buf2 (append buf2 po)
  )
  (entmake buf2)
  (princ )
)

(defun n_incircle( po p1 r)
    ;; (setq 
    ;; buf (n_gd10 '(10 40))
    ;; po (car (mapcar 'n_gdd buf))
    ;; p1 (gp)
    ;; r (cadr (mapcar 'n_gdd buf))
    ;; )
   
 
  (if (>= (distance po p1) r) T nil )
   

)

;; int2ang
(defun n_arccos( in / out delta  )
  ;; in -1 ~ 1
  ;;  out 0 ~ PI

  (setq delta 0.1
        out 0
        ;; in 0.5
  )

  (while (> delta 0.00000001)

    (if (>(cos out ) in )
        (while (and (>(cos out ) in ) (< (+  out delta) pi) )
          (setq out (+  out delta))
        )

        (while (and (<= (cos out ) in ) (> (-  out delta) 0) )
          (setq out (-  out delta))
        )
    )

    (setq delta (/ delta 10.0))
     
  )
  
  ;; out
  (/ out pi (/ 1 180.0))

)
;; int2ang
(defun n_arcsin( in / out delta  )
  ;; in -1 ~ 1
  ;;  out -pi/2 ~ pi/2

  (setq delta 0.1
        out (- (/ pi 2))
        ;; in 0.5
  )

  (while (> delta 0.00000001)

    (if (>(sin out ) in )
        (while (and (>(sin out ) in ) (> (-  out delta)   (- (/ pi 2)) ) )
          (setq out (-  out delta))
        )

        (while (and (<= (sin out ) in ) (< (+  out delta)  (+ (/ pi 2)) ) )
          (setq out (+  out delta))
        )
    )

    (setq delta (/ delta 10.0))
     
  )
  
  ;; out
  (/ out pi (/ 1 180.0))

)
;; ang2int
(defun n_tan( in / out delta  )
  
  (setq in (/ in 180 (/ 1 pi)))

  (/ (sin in) (cos in))

)
;; int2ang
(defun n_arctan( in / out delta maxint )

  ;; in - ~ +
  ;;  out -pi/2 ~ pi/2

  (setq delta 1.0
        out -90
        maxint (atoi "1.63312e+016")
        ;; in 0.5
  )





  (while (> delta 0.00000001)

    (if (>(n_tan out ) in )
        (while (and (>(n_tan out ) in ) (> (-  out delta)   (- 90) ) )
          (setq out (-  out delta))
        )

        (while (and (<= (n_tan out ) in ) (< (+  out delta)  (+ 90) ) )
          (setq out (+  out delta))
        )
    )

    (setq delta (/ delta 10.0))
     
  )
  
  out
   

)

(defun n_tu2r( / p1 tu p2)

  (setq buf (n_gd10 '(10 42))
        x 0
        as (list )
  )

  (repeat (length buf)
    (if (and (= 42(car (nth x buf)))  (not (= 0 (cdr (nth x buf))))  )
      (setq 
      x2 x
      x1 (1- x)
      x3 (1+ x)
      a1 (list (cdr (nth x1 buf)) (cdr (nth x3 buf)) (cdr (nth x2 buf)) )
      ;; as (append as (list a1))

      a (/ 
      (distance (nth 0 a1) (nth 1 a1))  2 
      (cos (/ (- 90 (* 2 (n_arctan  (nth 2 a1) ))) 180 (/ 1 pi)))
      )

      ;;  0 1  2  3 4  5
      ;; p1 p2 tu r p0 k
      a1 (append a1 (list a) 
        (list (mapcar '/ (m_poadd (nth 0 a1) (nth 1 a1) )  (m_poRep 2 (length (nth 0 a1) )) ))  
        (list (apply '/ (m_posub (nth 0 a1) (nth 1 a1) )))  )
      

      ;; y=-1/k(x-x1)+y1   m=1 n=1/k l=-(x1/k + y1)
      pk (n_22_21funcEx (nth 0 a1) (nth 3 a1) (nth 4 a1) (nth 5 a1))          
      

      a1 (append a1 (list pk))
      as (append as (list a1))

      )   
    )


    (setq x (1+ x))
  )



  as
  
)

(defun n_opro( p1 p2 / )
  (setq 
      l (car p1)
      m (cadr p1)
      n (if (= nil (caddr p1)) 0 (caddr p1) ) 
      o (car p2)
      p (cadr p2)
      q (if (= nil (caddr p2)) 0 (caddr p2) ) 
  )

  (list (- (* m q) (* n p)) (- (* n o) (* l q)) (- (* l p) (* m o)) )
)

(defun n_nt(words / p1 v1 word x xx)



    (initget 1 "Yes No")
    (setq xx (getkword "x anxis Y/N ?"))


    (setq p1 (gp)    ;; �����l�I
          v1 (if (= xx "Yes") '(17  0 0) '(0 -7 0))
          ;; v1 '(0 -7 0)  ;;�W����V
          ;; v1 '(17  0 0)
          ;; word ""
          ;; words nil
          ;; words (list "�ڪ�" 123 456 "�L��")
          x 0
    )






    (if (= words nil)
    (while (not (= "" (setq word (getstring) )))

        ;; (princ "CCCC\n")
        (vl-cmdf "text" "j" "ml" p1 3 0 word)
        (setq p1 (m_poAdd p1 v1))
    )
    (repeat (length words)
        (vl-cmdf "text" "j" "ml" p1 3 0 (nth x words) )
        (setq p1 (m_poAdd p1 v1)
              x (1+ x)
        )
    )


    )



    (princ )


)

(defun n_read( / bufs buf f) 
    (setq f (open "E:\\ZCM\\a.txt" "r"))
    (while (setq buf (read-line f))
        (setq bufs (append bufs (list buf)))
    )
  bufs
)
 
(defun n_cno(a b / buf x)
    (setq x 1)
    (repeat b 

        
        (setq 
          buf (append buf (list (strcat (itoa a) "-" (itoa x))))  
          x (1+ x))
    )
  buf
)



(defun n_noff()

  (setq buf (ssget))
  (while (setq a (gp))
      (vl-cmdf "offset" "t" buf a "")
  )
)


(defun n_r90()
  (setq a (ssget)
        b (entget (ssname a 0))
        c (cdr (car (n_gd10ex b (list 10))))
  )
  (vl-cmdf "rotate" a  "" c  90 )

)
 


 

(defun c:as( / )
  (k_cond)
)

(defun c:ad( / )
  (apply 'vl-cmdf  (read k_t4) )
)



(defun c:np() (vl-cmdf "plot" "N" "" "前次出圖" "" "" "" ""))



(defun c:kload()
    ;; full path
    (vl-load-all (strcat kpl "kitty.lsp") )
    (princ )
)


(princ)




 
 
