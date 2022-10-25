; MODULE_ID ACAD2007_LSP_
;;;    ACAD2014.LSP Version 1.0 for AutoCAD 2014
;;;
;;;  Copyright 2013 Autodesk, Inc.  All rights reserved.
;;;
;;;  Use of this software is subject to the terms of the Autodesk license 
;;;  agreement provided at the time of installation or download, or which 
;;;  otherwise accompanies this software in either electronic or hard copy form.
;;;
;;;
;;;
;;;    Note:
;;;            This file is normally loaded only once per AutoCAD session.
;;;            If you wish to have LISP code loaded into every document,
;;;            you should add your code to acaddoc.lsp.
;;;
;;;    Globalization Note:   
;;;            We do not support autoloading applications by the native 
;;;            language command call (e.g. with the leading underscore
;;;            mechanism.)


 


;; ========================BEFOR FUNCTION==============================

;; ����ϼh��
(defun m_getLays( / lays layName layNames re )

      (setq  lays (TBLNEXT "LAYER" 'T))
      (setq layName (cdr (assoc 2 lays )))
      (setq layNames (list layName))
 

      (while  lays
            (setq  lays (TBLNEXT "LAYER" ))
            (setq layName (cdr (assoc 2 lays )))      
            (IF (/= lays NIL)
                  (progn
                  (setq layNames (append (list layName) layNames))
      
                  )  
            )
      )

       
      (setq re layNames)
      
)

;; ����϶���
(defun m_getBlocks( / block blockName blockNames re)

      (setq  block (TBLNEXT "block" 'T))
      (setq blockName (cdr (assoc 2 block)))
      (if (/= "*" (substr blockName 1 1) )
            (progn
            (setq blockNames (list blockName))
            ;; (princ blockName)
            ;; (princ "\n")
            )
      )

      

      (while  block
            (setq  block (TBLNEXT "block" ))

            (IF (/= block NIL)
                  (progn
                  (setq blockName (cdr (assoc 2 block)))


                  (if (and (/= "*" (substr blockName 1 1) )  (/= "" blockName) )
                  (progn
                  (setq blockNames (append (list blockName) blockNames))
                  ;; (princ blockName)
                  ;; (princ "\n")
                  )
                  )

                  )  
            )
      )

      (setq re blockNames)
)



 
;; ========================param==============================
 



(setq 
      d1_c1  1000.0       
      d1_c2  1000.0       
      d1_c3  0.0       
      d1_c4  1.0       
      d1_c5  1.0       

      ;; �r�Ŧ��l�Ů�
      d1_c6  "<>" 
      d1_c7  ""
      d1_c8  ""
      d1_c9  1.0
      d1_c10 1.0 


      d1_l1  4.0
      std2 1





)
 
(setq  
      y1  d1_c1 
      y2  d1_c2 
      y3  d1_c3
      BlockList  (m_getblocks)
      m_lays 0  ;;�϶�
      LayList (m_getLays)
      m_lays2 0  ;;�ϼh

      m_str d1_c6
      v_scale d1_c4

      ;; m_slide m_dcl
      m_path "C:\\Program Files\\Autodesk\\AutoCAD 2014\\Support\\"

)
;; ========================FUNCTION==============================




(DEFUN Box_Limits (  / Half leftup rightlow)
      (SETQ 
            ViewH (GETVAR "VIEWSIZE")
            Cen (TRANS (GETVAR "VIEWCTR") 1 2)
            ;; --------------------------------

            Half (LIST (* 0.3 ViewH) (* -0.5 ViewH)) 
            leftup (TRANS (MAPCAR '- Cen Half) 2 1) 
            rightlow (TRANS (MAPCAR '+ Cen Half) 2 1))

      (COMMAND "_RECTANG" leftup rightlow)
      (TRANS leftup 1 2)
)

(DEFUN Box_ViewExts (  / Half)
      (SETQ 
            Pixels (GETVAR "SCREENSIZE")
            ViewH (GETVAR "VIEWSIZE")
            Cen (TRANS (GETVAR "VIEWCTR") 1 2)
            ;; --------------------------------

            Half (LIST (* 0.5 ViewH (APPLY '/ Pixels)) (* 0.5 ViewH)))


      (COMMAND "_RECTANG" (TRANS (MAPCAR '- Cen Half) 2 1) ; lower left
            (TRANS (MAPCAR '+ Cen Half) 2 1) ; upper right
      )
      (LIST (TRANS (MAPCAR '- Cen Half) 2 1) ; lower left
            (TRANS (MAPCAR '+ Cen Half) 2 1) ; upper right
      )
)
 

(DEFUN Box_Make ()
      (IF	(NOT (TBLSEARCH "STYLE" "$Box@2007$"))
      (ENTMAKEX	(LIST 
                  '(0 . "STYLE")		 
                  '(100 . "AcDbSymbolTableRecord")
                  '(100 . "AcDbTextStyleTableRecord")
                  '(2 . "$Box@2007$")	 
                  '(70 . 0)
                  '(40 . 0.0)		 
                  '(41 . 0.7)
                  '(50 . 0.0)		 
                  '(71 . 0)
                  '(42 . 300.)		 
                  '(3 . "ROMANS")
                  '(4 . "HZTXT")
                  )
      )
      )
      (IF	(NOT (TBLSEARCH "BLOCK" "$Box@2007$"))
      (PROGN ;;��??
            (ENTMAKEX (LIST 
                        '(0 . "BLOCK")	       
                        '(100 . "AcDbEntity")
                        '(100 . "AcDbBlockBegin") 
                        '(2 . "$Box@2007$")
                        '(70 . 2)		       
                        '(10 0. 0.)
                        )
            )
            ;;��?
            (ENTMAKEX (LIST 
                        '(0 . "SOLID")	    
                        '(100 . "AcDbEntity")
                        '(100 . "AcDbTrace")   
                        '(62 . 0)
                        '(10 -0.5 -0.5)	    
                        '(11 -0.5 0.5)
                        '(12 0.5 -0.5)	    
                        '(13 0.5 0.5)
                        )
            )
            ;;?��
            (ENTMAKEX (LIST 
                        '(0 . "LWPOLYLINE")    
                        '(100 . "AcDbEntity")
                        '(100 . "AcDbPolyline")
                        '(6 . "Continuous")    
                        '(62 . 252)
                        '(43 . 0.03)	   
                        '(38 . 0.0)
                        '(39 . 0.0)	   
                        '(90 . 4)
                        '(70 . 1)		    
                        '(10 -0.5 -0.5)
                        '(10 -0.5 0.5)	   
                        '(10 0.5 0.5)
                        '(10 0.5 -0.5)
                        )
            )

            (ENTMAKEX (LIST '(0 . "LWPOLYLINE")    '(100 . "AcDbEntity")
                        '(100 . "AcDbPolyline")
                        '(6 . "Continuous")    '(62 . 252)
                        '(43 . 0.03)	    '(38 . 0.0)
                        '(39 . 0.0)	    '(90 . 4)
                        '(70 . 1)		    '(10 -0.25 -0.25)
                        '(10 -0.25 0.25)	    '(10 0.25 0.25)
                        '(10 0.25 -0.25)
                        )
            )

            (ENTMAKEX (LIST '(0 . "LWPOLYLINE")     '(100 . "AcDbEntity")
                        '(100 . "AcDbPolyline") '(6 . "Continuous")
                        '(62 . 252)	     '(43 . 0.03)
                        '(38 . 0.0)	     '(39 . 0.0)
                        '(90 . 2)		     '(10 -0.5 -0.5)
                        '(10 -0.25 -0.25)
                        )
            )

            (ENTMAKEX (LIST '(0 . "LWPOLYLINE")    '(100 . "AcDbEntity")
                        '(100 . "AcDbPolyline")
                        '(6 . "Continuous")    '(62 . 252)
                        '(43 . 0.03)	    '(38 . 0.0)
                        '(39 . 0.0)	    '(90 . 2)
                        '(10 0.5 0.5)	    '(10 0.25 0.25)
                        )
            )

            (ENTMAKEX (LIST '(0 . "LWPOLYLINE")     '(100 . "AcDbEntity")
                        '(100 . "AcDbPolyline") '(6 . "Continuous")
                        '(62 . 252)	     '(43 . 0.03)
                        '(38 . 0.0)	     '(39 . 0.0)
                        '(90 . 2)		     '(10 -0.5 0.5)
                        '(10 -0.25 0.25)
                        )
            )

            (ENTMAKEX (LIST '(0 . "LWPOLYLINE")     '(100 . "AcDbEntity")
                        '(100 . "AcDbPolyline") '(6 . "Continuous")
                        '(62 . 252)	     '(43 . 0.03)
                        '(38 . 0.0)	     '(39 . 0.0)
                        '(90 . 2)		     '(10 0.5 -0.5)
                        '(10 0.25 -0.25)
                        )
            )

            ;;��?��
            (ENTMAKEX (LIST 
                        '(0 . "ENDBLK")
                        '(100 . "AcDbEntity")
                        '(100 . "AcDbBlockEnd")
                        )
            )

      )
      )
)









;; ���W
(defun m_blockName ( / a )
      ;; �ɶ��W �p�Ʀ�16

      (setq a (list (substr (rtos (rem (getvar "Date") 1) 2 10 ) 3 10) (rtos (getvar "CPUTICKS") 2 0)))
      (strcat "A$C" (substr (car a) 2) (substr (cadr a) 2))

)
 
(defun m_rand( p1 )
      (setq 
            a (list 
                  (atof (substr (rtos (rem (getvar "Date") 1) 2 10 ) 3 10))  
                  (atof (rtos (getvar "CPUTICKS") 2 0))
                  )

            b (+ (car a) (cadr a) )   

            c (rtos b 2 6)
            d (substr c 1 14)
            e (cadr (m_maMo (atof d) p1 ))
      )
   
)


;; �ն� 
(defun m_oriBlock( ss buf1 / buf buf1)

      ;; ss point

      (setq buf (m_blockName))


      (vl-cmdf "-block"  buf buf1 ss "" )
      (vl-cmdf "-insert" buf buf1 "" "" ""  )

 
      (list buf buf1)

)


;; ss0
(defun m_ssl( / ss )

      (setq ss (ssget))
      (list  (ssname ss 0) (list 0 0 0))
)

(defun m_sslN(ssn)
      (list ssn (list 0 0 0))
)



;; ss0
(defun m_getData( ss / )
      (entget (ssname ss 0))
)

;; ����ƾ�
(defun m_getDataA (p3)
      (entget (car p3))
)



;; ss0
(defun m_getLay()
      (cdr (assoc 8 (entget (ssname (ssget) 0))))
)

;; �����e�ϼh
(defun m_setLLay()
      (vl-cmdf "layer" "s" (m_getLay)  "" )
      (princ)
)

;; �w����Y��
(defun m_scale( scale / )

      (vl-cmdf "scale" (ssget) "" (getpoint "po\n") scale)
      (princ)
)

;; �h�����
(defun mrot ( / ss pnt2 num x  ang ename )
      (prompt "Select Entities to Rotate, <ENTER> for SSX.")
      (setq ss (ssget))
      (setq pnt2 (getpoint "point"))


      (if (not ss) (setq ss (ssx)))
      (setq num (sslength ss))
      (setq x 0)
      (if ss 
      (if (setq ang (getreal "Enter Rotation Angle: "))
            (repeat num
                  (setq ename (ssname ss x))
                  (princ ename)
                  ;; (setq elist (entget ename))
                  ;; (setq pnt (cdr(assoc 10 elist)))
                  (command "copy" ename (list 0 0 0) (list 0 0 0) "" "" "" )
                  (princ )
                  (command "Rotate" ename "" pnt2 ang)
                  (setq x (1+ x))
            )
            )
      )


)


;; ��s�Ѽ�
(defun mdata()

      (setq y1  (atof (get_tile "y1")))
      (setq y2  (atof (get_tile "y2")))
      (setq y3  (atof (get_tile "y3")))
      (setq v_scale  (atof (get_tile "y4")))
      (setq m_str   (get_tile "y5"))




      (setq m_lays    (atof (get_tile "m_lays")))
      (setq m_lays2   (atof (get_tile "m_lays2")))


      (princ "\n")
 


)


;; �ΰѼƧ�sUI
(defun sdata()

      (set_tile "y1" (rtos y1))
      (set_tile "y2" (rtos y2))
      (set_tile "y3" (rtos y3))
      (set_tile "y4" (rtos v_scale))   
      (set_tile "y5"  m_str)  
 

      (set_tile "m_lays" (rtos m_lays))
      (set_tile "m_lays2" (rtos m_lays2))



)

 
 
;; �u�q�_�l�I
(defun m_getTwopoint(p3 / p1 p2 buf)

      (setq 
            buf (m_getDataA p3)
            p1 (cdr (assoc 10 buf))
            p2  (cdr (assoc 11 buf))      
      )

      (list p1 p2)

      ;;      (list 
      ;;       (list (cadr (assoc 10 (entget (nth 0 p3 )))) (caddr (assoc 10 (entget (nth 0 p3 )))))
      ;;       (list (cadr (assoc 11 (entget (nth 0 p3 )))) (caddr (assoc 11 (entget (nth 0 p3 )))))

      ;;       )

 

)


;; �����V
(defun m_getVec(p8 p9)

      (m_poAdd p9 (m_poUn p8))


      ;; (list  (- (car p9) (car p8))  (- (cadr p9) (cadr p8)))

      

)


;; �w���Y��
(defun m_getVec2(vec alp / x y buf )
      (cond  
            ((> 0.000000001 (abs (car vec)))    (list alp 0)  )
            ((> 0.000000001 (abs (cadr vec)))   (list 0 alp)  )
            (progn
            
                  (setq 
                        x 100 
                        y (- (* (/ (car vec) (cadr vec)) x))
                        buf (/ alp (m_poMo (list x y )))
                  )
                  ( list (* buf x)  (* buf y) )           
            )
      )
)

;; ��V�ϦV
(defun m_getUnVec(vec2)
      (m_poUn vec2 )
      ;; (list (- (car vec2))  (- (cadr vec2)))
)


;; ��������I
(defun m_getOffpoint(p8 vec2 vec21)
     (list  
      (m_poAdd p8 vec2)
      (m_poAdd p8 vec21)
     )
)



;; �����AExtend
(defun m_offSet(p3 y1 p81 lay / a )

      (command "offset" y1 p3 p81 "")
      (m_change (entlast) lay)
)




;; ���u
(defun m_mlv(p8 p81 p91 lay  )

      (command "line" p8 p81 "")
      (setq a (entlast ))
      (m_change a lay)

      (command "line" p8 p91 "")
      (setq b (entlast ))
      (m_change b lay)

      (command "join" a b "")

      (entlast)
)


;; �ק�ϼh �Ause change
(defun m_change (p3 lay)
      (command  "change" p3 "" "p" "la"  lay  "")
)
 

;; �ק�ϼh �Ause dxf
(defun m_change2(lay /ss_data old_layer new_layer new_data)

      ;; (cdr (assoc 8 (entget (ssname (ssget) 0))))
      (setq ss_data (entget (ssname (ssget) 0)))


      (setq old_layer (assoc 8 ss_data))
      (setq new_layer (cons 8 lay ))

      (setq new_data (subst new_layer old_layer ss_data))
      (entmod new_data)
      (princ)


)




;; ���䰾���A��ܫ��u

(defun ml(p3 y3 alp y1  lay / p8 p81 P82 p9 p91 P92 vec vec2 vec21 alp x y a b buf ss re)

      ;; �l��


      (setq 
            ss (ssadd) 

            buf (m_getTwopoint p3)   ;;���I
            p8 (car buf ) 
            p9 (cadr buf )

            vec (m_getVec p8 p9) ;; ��V
            vec2 (m_getVec2 vec alp)  ;; ���u��V
            vec21 (m_getUnVec vec2) ;; �ϦV
  

            buf (m_getOffpoint   p8 vec2 vec21)  
            p81 (car buf )
            p82 (cadr buf )
          
            buf (m_getOffpoint   p9 vec2 vec21)  
            p91 (car buf )
            p92 (cadr buf )

        )

      (if (not (= y3 0))
            (progn 
              (m_mlv p8 p81 p82 lay)  ;;���u
              (ssadd (entlast) ss)
              (m_mlv p9 p91 p92 lay)
              (ssadd (entlast) ss)
            
            )
           
      )
      
   

      (m_offSet p3 y1 p81 lay)
      (ssadd (entlast) ss)

      (m_offSet p3 y1 p82 lay)
      (ssadd (entlast) ss)
  
      (setq re ss)

)
 
(defun c:mlEx( / buf dis p1 p2 vec ss lay )
      (setq
            buf (ssname (ssget) 0) ;;(entsle)

            ;; (cdr (assoc 10 (ssname (ssget) 0)))
            dis (/ y1 2) 
            p1  (cdr (assoc 10 (entget buf) ))
            p2  (cdr (assoc 11 (entget buf) )) 
            vec (m_posub p1 p2)  ;;�T�I
            vec (append (m_getVerA vec) '(0))
            p1 (m_poAdd vec p1)
            p2 (m_posub vec p1)
            ss  (ssadd)
            lay (nth (atoi (rtos m_lays2)) LayList)   ;;"0"
      )

      ;; (princ "here")

      (vl-cmdf  "offset" dis  buf p1 "")
      (ssadd (entlast) ss)
      (vl-cmdf  "offset" dis  buf p2 "")
      (ssadd (entlast) ss)

      (m_change ss lay)
      (if (not (= y3 0)) (vl-cmdf "ERASE" buf ""))


)





;; �����u�q
(defun ml2(p3 alp alp2  lay /  p8 p81 p9 p91 vec vec2 vec21 alp x y a b buf buf2 buf3 vecs )

      ;; �l��


      (setq 
            buf (m_getTwopoint p3)  
            p8 (car buf ) 
            p9 (cadr buf )

            buf (m_poAdd p9 (m_poUn p8))  ;;�ۥ[
            buf2 (m_poAdd p8 (m_poScaSC buf (/ 1 alp2)))  ;;���I??
            
            vec (m_getVec p8 p9) ;; ��V
          

            vec2 (m_getVec2 vec alp) ;; ���u��V
            vec21 (m_getUnVec vec2) ;; �ϦV

            buf3 (m_getOffpoint   buf2 vec2 vec21) 
            p81 (car buf3 ) 
            p91 (cadr buf3 )
      )

     
      (m_mlv buf2 p81 p91 lay)
 
      (princ )

)



;; ��s�Ϸ�
(defun m_blockImage( / Name x path re)

 
      (setq num (length BlockList))
      (setq x 0)

      (repeat num

            (setq Name (nth x BlockList)

           

            path (strcat m_path "m_slide\\"   Name  ".sld")   
            )

            (if (not (findfile path))
                  (progn
                  (vl-cmdf "bedit" Name)
                  (vl-cmdf "mslide"  path )
                  (vl-cmdf "bclose" "d")
                  )

            )



            (setq x (1+ x))
      )


 
       
)



;; ��s��
(defun m_setBlockImage( / Name)

      (setq Name (nth (atoi (rtos m_lays)) BlockList))

      (start_image "blockImage") 

      (fill_image 0 (- (/ (dimy_tile "blockImage") 2)) (dimx_tile "blockImage") (dimy_tile "blockImage")  -2
      ) 


      ;; �|�[
      (slide_image 0 (- (/ (dimy_tile "blockImage") 2)) (dimx_tile "blockImage") (dimy_tile "blockImage")  (strcat m_path "m_slide\\"   Name  ".sld") 
      ) 

      (end_image)	
 

      (princ)
)

 

;; use ss as param ,Extend ssadd
(defun m_ssAdd( buf ss / re )
      (setq num (sslength buf))
      (setq x 0)


      (repeat num
            (ssadd (ssname buf x) ss)
      (setq x (+ x 1))
      )

      (setq re ss)
)


;; �I�ۥ[
(defun m_poAdd( p1 p2 / )   (mapcar '+ p1 p2))





;;�I�۴� �����
(defun m_posub(p1 p2 /)  (mapcar '- p2 p1))





;; �I�ϦV �u��2�I
(defun m_poUn( p1 /)
      (list (- (car p1 )) (- (cadr p1 )))

)

;; �I�ϦVEx 
(defun m_poUnEx( p1 / num x re )
      (setq num (length p1)
            x 0
            re (list )
      )
      (repeat num


            (setq 
            re (m_appendEx  re  (- (nth x p1)) )
            x (1+ x))
      )

      re
)


;; �Ix�ϦV �u��2�I
(defun m_poUnX( p1 /)
      (list (- (car p1 ))  (cadr p1 ))

)


;; �I�洫xy �u��2�I
(defun m_poSwap( p1 /)
      (list (cadr p1 )  (car p1 ))

)




;; �I�Ҫ� �u��2�I
(defun m_poMo( p1 / re)

      (setq re  (sqrt (+ (expt (car p1) 2) (expt (cadr p1) 2)))  )
)



;; �I�Y��w�ȡA�O����V �u��2�I
(defun m_poSca( p1 sc / len alp )
      (setq len (m_poMo p1)
            alp  (/ sc len)
      )
      (list (* alp (car p1)) (* alp (cadr p1)))
)


;; �I�Y���� �u��2�I
(defun m_poScaSC( p1 sc / len alp )
      
      (list (* sc (car p1)) (* sc (cadr p1)))
)


;; �L���I���u
(defun m_Midli( base p / p1 p2 )

      (setq p1  (m_poAdd base (m_poScaSC p 0.5))
            p2  (m_poAdd base (m_poUn (m_poScaSC p 0.5)))
      )

      (vl-cmdf "line" p1 p2 "")

      (list p1 p2)

)


;; ���k �өM�l��
(defun m_maMo( p1 p2 / buf re re2 )

      (setq 
            buf  (/ (m_itof p1) (m_itof p2))
            re (fix buf)
            re2 (- p1 (* re p2) )     
       )

      


      (list re re2)
)


;; �|�ˤ��J
(defun m_maFloor(p / buf buf2 buf3)

      (setq 
            buf (fix p)
            buf2  (- p buf)
      )


      (if (>= buf2 0)
            (progn
                  (if (>= buf2 0.5)  ;;0~1
                  (setq buf3 (+  buf 1)) 
                  (setq buf3  buf ) 
                  )
            
            )
      
            (progn
            
                  (if (<= buf2 -0.5)  ;;-1~0
                  (setq buf3 (-  buf 1)) 
                  (setq buf3  buf ) 
                  )
            
            )
      
      )




)



;; int to float
(defun m_itof ( p)

      (atof (rtos p))
)



;; 90 to PI & 360 to 2PI 
(defun m_maAng( p1 / )

      
     (+     (angtof (rtos p1)) 
            (*  (car (m_maMo p1 360)) (* 2 pi))
            
      )

)

;; ���p0,���u
(defun m_getVerA( vec / base target  )

      ;; (setq 
      ;;       base (getpoint "base\n")
      ;;       target (getpoint "target\n")
      ;;       vec (m_poAdd target (m_poUn base))
      ;; )

      ;; (setq vec (m_poSwap vec))
      

      (cond 
            ((< (abs (car vec)) 0.00000001)
            (setq vec (list 0 (cadr vec))))
      
            ((< (abs (cadr vec)) 0.00000001)
            (setq vec (list (car vec) 0)))
      
      )

      (princ vec)



      (cond ((> (cadr vec) 0)
                  (if (= (car vec) 0)
                  (list 1 0)
                  (list 1 (- (/ (car vec) (cadr vec))))
                  )
            )
         

            ((< (cadr vec) 0)
                  (if (= (car vec) 0)
                  (list (- 1) 0)
                  (list (- 1)  (+ (/ (car vec) (cadr vec))))
                  )
            )


            ((and (= (cadr vec) 0) (> (car vec)0) )
            (list 0 (- 1))
            
            )

            ((and (= (cadr vec) 0) (< (car vec)0) )
            (list 0 1)
            
            )


      
      
      )





      ;; (setq vec (m_poSwap vec))

)



(defun d1_setr()
      (setq sor (list "d1_r1" "d1_r2" "d1_r3" "d1_r4" "d1_r5" "d1_r6" "d1_r7")
            tar (mapcar 'rtos (m_poFlag std2 7))
      )

      (mapcar 'set_tile sor tar)
)

(defun m_poFlag(n1 n2 / x re)
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



(defun d1_setc()
      ;; �Ʀr��r�Ŧ�
      ;; (set_tile "d1_c1" (rtos d1_c1))
      ;; (set_tile "d1_c2" (rtos d1_c2))
      ;; (set_tile "d1_c3" (rtos d1_c3))
      ;; (set_tile "d1_c4" (rtos d1_c4))
      ;; (set_tile "d1_c5" (rtos d1_c5))

      (setq d15_s (list "d1_c1" "d1_c2" "d1_c3" "d1_c4" "d1_c5" "d1_c9" "d1_c10")
            d15_t (mapcar 'rtos (list d1_c1 d1_c2 d1_c3 d1_c4 d1_c5 d1_c9 d1_c10 )))
      
      (mapcar 'set_tile d15_s d15_t)

      ;; �r�Ŧ�
      (set_tile "d1_c6"  d1_c6)
      (set_tile "d1_c7"  d1_c7)
      (set_tile "d1_c8"  d1_c8)
      ;; (set_tile "d1_c9"  d1_c9)
      ;; (set_tile "d1_c10"  d1_c10)

      (set_tile "d1_l1" (rtos d1_l1))

)

(defun d1_setl()

      (setq          
      LayList (m_getLays))
    
      (start_list "d1_l1")
      (mapcar 'add_list LayList)
      (end_list)

)

(defun d1_con()
      (cond 
            ((= std 1) 
            (progn
                  (m_change (ssget) (nth (rtoi d1_l1) LayList))
            (setq std 0)
                  )) 
            ((= std 2) 
            (progn
            (vl-cmdf "ucs" "" )
            (setq std 0)
                  )) 
            ((= std 3) 
            (progn
            (vl-cmdf "dimbreak" "m" (ssget) "" "a" )
            (setq std 0)
                  )) 
            ((= std 4) 
            (progn
            (vl-cmdf "dimspace"  (entsel "base\n") (ssget) "" "0" )
            (setq std 0)
                  )) 
            ((= std 5) 
            (progn
            (d1_bus)
            (setq std 0)
                  )) 
            ((= std 6) 
            (progn
            (setq std 0)
                  )) 
            ((= std 7) 
            (progn
            (setq std 0)
                  )) 
            ((= std 8) 
            (progn
            (setq std 0)
                  )) 
            ((= std 9) 
            (progn
            (setq std 0)
                  )) 
            ;;============================================ 
            ((= std 10) 
            (progn
            (setq std 0)
                  )) 
            ((= std 11) 
            (progn
            (setq std 0)
                  )) 
            ((= std 12) 
            (progn
            (setq std 0)
                  )) 
            ((= std 13) 
            (progn
            (setq std 0)
                  ))             
            ((= std 14) 
            (progn
            (setq std 0)
                  )) 
            ((= std 15) 
            (progn
            (setq std 0)
                  ))  
            ((= std 16) 
            (progn
            (setq std 0)
                  ))  
            ((= std 17) 
            (progn
            (setq std 0)
                  ))  
            ((= std 18) 
            (progn
            (setq std 0)
                  ))  
            ((= std 19) 
            (progn
            (setq std 0)
                  ))  
            ((= std 20) 
            (progn
            (setq std 0)
                  ))  
      )
)

(defun d1_bus()
       (cond 
            ((= std2 1) 
            (progn
                  (vl-cmdf "hideobjects" (ssget) "" )
                  )) 
            ((= std2 2) 
            (progn
                  (vl-cmdf "unIsolateObjects")
                  )) 
            ((= std2 3) 
            (progn
                  (vl-cmdf "layoff" (m_ssl) "")
                  )) 
            ((= std2 4) 
            (progn
            
                  (vl-cmdf "layon" )
                  )) 
            ((= std2 5) 
            (progn
                  ;; (princ "bus5")
                  (m_scale v_scale)
                  )) 
            ((= std2 6) 
            (progn
                  (vl-load-all "acad2014.lsp")
                  )) 
            ((= std2 7) 
            (progn
                  (DICTREMOVE  (NAMEDOBJDICT) "ACAD_DGNLINESTYLECOMP" )
                  (command "zoom" "e")
                  (vl-cmdf "purge" "a" "" "n")
                  (vl-cmdf "_qsave") 
                  )) 

       )
)


;; d1
(defun mgta(  / dlg_name dlg_file dlg_id std)

      (setq 
            dlg_name   "d1"  
            dlg_file  (strcat m_path "m_dcl\\ob1") 
            dlg_id (load_dialog dlg_file)
            std 2
      )

      ;; �r�Ŧ�ϱק��S���Ÿ� ,�޸����޸�



      (while (>= std 1)

            (if (not (new_dialog  dlg_name dlg_id   )) (exit))

            (d1_setc)
            (d1_setl)
            (d1_setr)
            (setq std (start_dialog))
            (d1_con)

      )
 
      
      (unload_dialog dlg_id)
      (princ )

)


;; r i a s
(defun rtoi(p)
      (atoi (rtos p)) 
)





  
;; �[��UI
(defun mg3( / dlg_name dlg_id std mp)




    (setq
      dlg_name  "d2"  
      dlg_file  (strcat m_path "m_dcl\\ob1") 
      dlg_id (load_dialog dlg_file)
      std 2
      mp '(700 100) ;;(m_poScaSC (getvar "screensize") 0.6 ) 
      )



    (if (< dlg_id 0) (exit))
  
    (while (>= std 1)

        
      (if (not (new_dialog dlg_name dlg_id ""  mp )) (exit))


      ;; -----init list----
      (mg3InitList )

      ;; -----init image----
      (m_setBlockImage)

      (sdata )

      ;;-------here move to dcl------ 
      ;; (action_tile "accept"  "(mdata ) (done_dialog 1)")
      (action_tile "cancel"  "(mdata ) (done_dialog 0)")

      (setq std (start_dialog))
        
      ;; ----------splite to other?--------
       
      (setq std (mg3Splite std))
     
    )

 
      (sdata )    
      (unload_dialog dlg_id)

)
 

(defun mg3Splite( std / re )

            (cond     
            ((= std 1) 
            (progn
                  (sdata )
                  ;; (princ "sure\n")))
                  ;; (m_blockImage)
                  (setq std 1)
                  (princ)
            ))

            ;; ------------------------------------

            ((= std 3) 
            (progn
                  (sdata )
                  (m_change (ssget) (nth (atoi (rtos m_lays2)) LayList))
                  (setq std 0)
                  (princ)

                  )) 
            ((= std 4) 
            (progn
                  (sdata )
                  ;; (princ "buf2\n")
                  (vl-cmdf  "refclose"  "s" "" )
                  (setq std 0)
                  (princ)

                  )) 
            ((= std 5) 
            (progn
                  (sdata )
                  ;; (princ "buf3\n")
                  ;; (command "zoom" "e")
                  (vl-cmdf "ucs" "" )
                  (setq std 0)
                  (princ)
                  )) 

            ;; ----------------------------------
            
            ((= std 6) 
            (progn
                  (sdata )
                  ;; (princ "buf4\n")
                  (vl-cmdf "amdimbreak" "m" (ssget) "" "a" )
                  (setq std 0)
                  (princ)

                  )) 
            ((= std 7) 
            (progn
                  (sdata )
                  ;; (princ "buf5\n")
                  (vl-cmdf "dimspace"  (entsel "base\n") (ssget) "" "0" )
                  (setq std 0)
                  (princ)

                  )) 

            ((= std 8) 
            (progn
                  (sdata )
                  ;; (princ "buf6\n")
                  
                  (vl-cmdf "unIsolateObjects")
                  (setq std 0)
                  (princ)
                  )) 

            ;; ----------------------------------

            ((= std 9) 
            (progn
                  (sdata )
                  ;; (princ "buf6\n")
                  (vl-cmdf "hideobjects" (ssget) "" )
                  (setq std 0)
                  (princ)

                  )) 
            ((= std 10) 
            (progn
                  (sdata )
                  (vl-load-all "acad2014.lsp")
                  (setq std 0)
                  ;; (princ "buf6\n")
                  (princ)

                  )) 
            ((= std 11) 
            (progn
                  (sdata )
                  (m_scale v_scale)
                  (setq std 0)
                  ;; (princ "buf6\n")
                  (princ)
                  )) 

            ;; ----------------------------------

            ((= std 12) 
            (progn
                  (sdata )
                  
                  (vl-cmdf "layoff" (m_ssl) "")
                  ;; (vl-cmdf "layoff"  (nth (atoi (rtos m_lays2)) LayList) "")
                  (setq std 0)
                  ;; (princ "buf6\n")
                  (princ)
                  )) 
            ((= std 13) 
            (progn
                  (sdata )
                  (vl-cmdf "layon" )

                  (setq std 0)
                  ;; (princ "buf6\n")
                  (princ)
                  )) 

            ((= std 14) 
            (progn
                  (sdata )
                  (DICTREMOVE  (NAMEDOBJDICT) "ACAD_DGNLINESTYLECOMP" )
                  (command "zoom" "e")
                  (vl-cmdf "purge" "a" "" "n")
                  (vl-cmdf "_qsave")     
                  (setq std 0)
                  ;; (princ "buf6\n")
                  (princ)
                  ))

            
            ;; ----------------------------------



      )

      (setq re std)

)


(defun mg3InitList()



      (setq          
      BlockList  (m_getblocks)
      LayList (m_getLays))
       
      (start_list "m_lays")
      (mapcar 'add_list BlockList)
      (end_list)
 

       
      (start_list "m_lays2")
      (mapcar 'add_list LayList)
      (end_list)

)



;; ���߽u
(defun m_centCrossa( base vec1 r  / ss re  )

      (setq
            ;; base (getpoint "Cent")
            ;; r 100

            ;; 0.85d 0.1d 60

            ss (ssadd)

            buf2 (m_Midli base (m_poSca vec1 r))
            buf2 (m_change (entlast) "C")
            buf2 (ssadd (entlast) ss)



            buf2 (m_Midli base (m_poSca (m_getVerA vec1) r ))
            buf2 (m_change (entlast) "C")
            buf2 (ssadd (entlast) ss)

            re ss
      )


)

(defun m_centCrossb( base  r  / ss re  )

      (setq
            ;; base (getpoint "Cent")
            ;; r 100

            ;; 0.85d 0.1d 60

            ss (ssadd)
            vec1 (list 0 1)



            buf2 (m_Midli base (m_poSca vec1 r))
            buf2 (m_change (entlast) "C")
            buf2 (ssadd (entlast) ss)



            buf2 (m_Midli base (m_poSca (m_getVerA vec1) r ))
            buf2 (m_change (entlast) "C")
            buf2 (ssadd (entlast) ss)

            re ss
      )


)




 
;; �M���A�d�ݿ�ܶ�
(defun m_er(p) (vl-cmdf "erase" p ))

;; list ø�s��
(defun m_tc(p)

      (setq x 0)
      (repeat (length p)
            (vl-cmdf "circle" (nth x p) 20)
            (setq x (1+ x))
      )


)


;; ����I
(defun gp() (getpoint ))

;; ����ƾ�
(defun gd()(m_getDataA (m_ssl)))


;; �ƾڥh��
(defun m_dataRe( buf )  (vl-remove-if  'm_mem  buf ))
;; �t�X�ӤW
(defun m_mem(p)
      ;; �h��1 3 5
      (member (car p) (list 1  3  5 ))
)




(defun m_bre1( ml mp)
      ;; (setq ml (m_ssl))
      ;; (setq mp (getpoint "point")) 
      ;; (command "break"  (entsel "line") "f" mp mp)
      (vl-cmdf "break"  ml "f" mp mp)
)


;; �����ഫ�ѦҨt
;; ���_�_�I���Ϥ�,flag=0 ���_�ۨ�
(defun m_bre( flag / base base2 Data Data2  x re  buf )
      ;
      (setq base (m_ssl)
 
            Data (m_getTwopoint base)
            buf (vl-cmdf "_HideObjects" base "")

            Data2 (m_lsTpsEx (m_selF1 (car Data) (cadr Data)))
            buf (vl-cmdf "_UnIsolateObjects")


            base2 (car Data2) 
            Data2 (cadr Data2)

      
            x 0
            re (list )
      )


      (repeat (/ (length Data2) 2)
      
           (setq re (m_appendEx  re (inters (car Data) (cadr Data)  (nth x Data2) (nth (1+ x) Data2))  )
                  x (+ 2 x)
           )

      )

      (setq x 0
            ;; flag 0
            buf base
            )


      (command "._UNDO" "_Begin")
      (repeat (length re)
            ;; (vl-cmdf "circle" (nth x re) 20 )

            (if (= flag 1)
                  (m_bre1 (ssname  base2 x) (nth x re))     
                  (progn
                        (m_bre1 buf (nth x re))    
                        (setq buf (entlast))
                  )
            
            )
   
           
            ;; (m_bre1 base (nth x re))
            (setq x (1+ x))      
      )
      (command "._UNDO" "_End")



      (princ )

)

;; ����DXF
(defun m_mk( / p1 p2 buf)

      (setq p1 (gp)
            p2 (gp)
            p3 (gp)
            lst (list p1 p2 p3)
            r 100

            ;; p1 (m_append 10 p1)
            ;; p2 (m_append 11 p2)
            ;; buf (entmake (list (cons 0 "line") p1 p2 ))

            ;; ��
            ;; p1 (m_append 10 p1)
            ;; r (cons 40 r)
            ;; buf (entmake (list (cons 0 "circle") p1 r ))

            ;;  �꩷
            ;; buf (entmake        (list  
            ;; (cons 0  "ARC")  
            ;; p1
            ;; (cons 40  412.953)    
            ;; (cons 50  0) 
            ;; (cons 51  pi )
            ;; ))
             
            ;; ���u
            ;; buf (entmake  
            ;;       (append (list   (cons 0  "LWPOLYLINE") (cons 100  "AcDbEntity")  (cons 100  "AcDbPolyline") (cons 90  (length lst)))  
            ;;       (mapcar '(lambda(e1) (cons 10 e1) ) lst)
            ;;       )
            ;; )


            ;; ���u+��   cons = ��޸� + .
            ;; buf (entmake  (list '(0 . "LWPOLYLINE")   '(100 . "AcDbEntity") '(100 . "AcDbPolyline") '(90 . 6)  
            ;;       '(10 11183.9 4964.09)  
            ;;       '(10 11893.3 4964.09)  '(42 . -0.414214) ;;�Y�� �b�궶�ɰw
            ;;       '(10 12093.3 4764.09)  
            ;;       '(10 12093.3 4471.15)   '(42 . 0.414214) ;;�Y��
            ;;       '(10 12293.3 4271.15)  
            ;;       '(10 12694.9 4271.15)  
            ;;       '(210 0.0 0.0 1.0))
            ;; )

            ;; (m_ang)

      )


      

      ;; (/ (sin (m_maang (/ 90.0 4))) (cos (m_maang (/ 90.0 4))) )


)

;; �p��Y��,��J�B�I��
(defun m_poTu(Tu)

      (- (/ (sin (m_maang (/ Tu 4))) (cos (m_maang (/ Tu 4)))))
)


;;x�Ƨ�
(defun m_poSorX( p / buf1 buf2 buf )
      (vl-sort p '(lambda (e1 e2)
            (< (car e1) (car e2))
      )) 
)




;; ��iappend,�e�[
(defun m_append (p1 p2 /)
      (append (list p1) p2)
)
;;;; ��iappendEx,��[
(defun m_appendEx (p1 p2 /)
      (append p1 (list p2) )
)




;; ���I��� ,��u���ؤ���,����C�ϼh,SPL,������ ,�_�l�I����I
(defun m_selF( p1 p2 / re )
      ;; (setq p1 (getpoint)
      ;;       p2 (getpoint)
      ;; )

      (setq 
      re (ssget "F"  (list p1 p2)  '((-4 . "<not")
      (-4 . "<or")
            (-4 . "<and")
                  (0 . "LINE")
                  (8 . "C")
            (-4 . "and>")
            (-4 . "<and")
                  (0 . "SPLINE")
                  (8 . "0")
            (-4 . "and>")

      (-4 . "or>")
      (-4 . "not>")) )
      )

      re

      ;; (ssget "C"   p1 p2 '((-4 . "<not")
      ;; (-4 . "<or")
      ;;       (-4 . "<and")
      ;;             (0 . "LINE")
      ;;             (8 . "C")
      ;;       (-4 . "and>")
      ;;       (-4 . "<and")
      ;;             (0 . "SPLINE")
      ;;             (8 . "0")
      ;;       (-4 . "and>")

      ;; (-4 . "or>")
      ;; (-4 . "not>")) )
)
;; ���I��� �A���u
(defun m_selF1( p1 p2 / re )
      ;; (setq p1 (getpoint)
      ;;       p2 (getpoint)
      ;; )

      (setq 
      re (ssget "F"  (list p1 p2)  '(
                  (-4 . "<and")
                        (0 . "LINE")
                  (-4 . "and>")
      ))

      )

      re  
)


 



;; ��ܶ� ���I�B��u(entsel)
(defun m_SSTLL2( p1 p2 / buf ss p3 p4)
      (setq ss (m_selF p1 p2)
            buf (m_gettwopoint  (m_sslN (ssname ss 0)) )
            p3 (inters (car buf) (cadr buf) p1 p2 nil)

            buf (m_gettwopoint  (m_sslN (ssname ss 1)) )
            p4 (inters (car buf) (cadr buf) p1 p2 nil)
      )

      ;;inters
      (list (list (ssname ss 0)   p3) (list (ssname ss 1)  p4))
)


;; list��������
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

;; �u�q�����I�A�çR��
(defun m_lsTps( / ss num x re )
      (setq ss (ssget)
            num (sslength ss)
            x 0
            re (list )
            ;; re nil
      )

      (repeat num
            (setq 
                  re (append (m_getTwopoint (m_sslN (ssname ss x))) re)
                  x (+ x 1 )
            )
      )

      (vl-cmdf "erase" ss "")

      re

)
;; �u�q�����I�A�çR���X�i
(defun m_lsTpsEx( ss / ss num x re )
      (setq 
      ;; ss (ssget)
            num (sslength ss)
            x 0
            re (list )
            ;; re nil
      )

      (repeat num
            (setq 
                  re (append re (m_getTwopoint (m_sslN (ssname ss x))) )
                  x (+ x 1 )
            )
      )

      ;; (vl-cmdf "erase" ss "")

      (list ss re)

)


;; List�C�ӭ�l�p��
(defun m_poAllLow(p p2 / buf x re )

     (setq buf (mapcar '<  p (m_poRep p2 (length p))) 
            x 0
            re T
     )

      (repeat (length p)
            (if (not (nth x buf)) (setq re nil))
      
            (setq x (1+ x))
      )

      re 

)

;; List�������
(defun m_poAbs(p)
      (mapcar 'abs p)
)



;; �襤DIM
(defun m_ssDIM( / buf)

      (setq 
          
            buf (ssget "X" '(  
                  (-4 . "<and")
                  (8 . "DIM")
                  (-4 . "and>")
            )))
      (sssetfirst nil buf)
)

(defun c:d1()

       
      (setq 
            buf (entget  (ssname (ssget) 0) )
            p1 (cdr (assoc 13 buf)) 
            p2 (cdr (assoc 14 buf))
            p3 (cdr (assoc 10 buf))
            ver (m_posub p1 p2)  
      )
      ;; (vl-cmdf "dimlinear" p1 p2 "r" p1 p2 p3) 
       


      (setq a (getreal))

      (while (not (= a 0)) 
            (setq  
                  ver (append (m_poSca ver a) '(0))
                  p1 p2
                  p2 (m_poadd p2 ver)

            )
           (vl-cmdf "dimlinear" p1 p2 "r" p1 p2 p3) 
            (setq a (getreal))
      )


)



;; ========================WORK FLOW(HOT KEY)==============================


;; ���߽u

(defun c:32(   / ss re  )

      (setq
            ;; base (getpoint "Cent")
            ;; r 100

            ;; 0.85d 0.1d 60
            base  (getpoint "1\n")
            base2 (getpoint "2\n")
            ss (ssadd)


            vec1 (m_poAdd base2 (m_poUn base))
            r (m_poMo (m_poScaSC vec1 2.0))

            buf2 (m_Midli base (m_poSca vec1 r))
            buf2 (m_change (entlast) "C")
            buf2 (ssadd (entlast) ss)



            buf2 (m_Midli base (m_poSca (m_getVerA vec1) r ))
            buf2 (m_change (entlast) "C")
            buf2 (ssadd (entlast) ss)

            ;; buf2 (vl-cmdf "arc" "c" (getpoint) (getpoint) "a" -270)



            re ss
      )


)

 
(defun c:adding( / ss1 emax num total vari)
   (setq ss1 (ssget)
         emax (sslength ss1)
         num 0 
         total 0
   )
   (while (> emax num)
         (setq entlst (entget (ssname ss1 num))
               ent (cdr (assoc 0 entlst))
         )
         (if (= ent "TEXT")
                 (setq vari (atof (cdr (assoc 1 entlst)))
                       total (+ total vari)
                 )
         )
         (setq num (1+ num))
   )
   (prompt "Total number: ")
   (prin1 total)
   (princ)
)

;; ���μе�
(defun c:SpDIM (/ sel newpt ent edata elist)
    
 
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

;; ���е��}��
(defun c:LegLDIM ( / ss dimobjs)
  
 

  (vl-load-com)
  (if (and (setq ss (ssget '((0 . "DIMENSION"))))
           (setq dimobjs (mapcar 'vlax-ename->vla-object
                                 (vl-remove-if 'listp (mapcar 'cadr (ssnamex ss)))
                         )
           )
      )
    (foreach dim dimobjs
      (extlinefixedlensuppress dim :vlax-true)
      (vla-put-extlinefixedlen dim (* 2 (vla-get-textheight dim)))
    )
  )
  (princ)
)


;;  UI
(defun c:`1()
      (mgta )
)

;; ����
(defun c:`11()


      ;; (ml (entsel "line\n")  y3 y2  y1 lay )
      (ml (m_ssl)  y3 (/ y2 2)  (/ y1 2) (nth (atoi (rtos m_lays2)) LayList) )
)

;; ���ϼh�AUI��w
(defun c:`12()
      (m_change (ssget) (nth (atoi (rtos m_lays2)) LayList))
)

;; ���ϼh�A�ꪫ����
(defun c:`122()
      (m_setLLay)
      (princ)
)
 
;; �h�q���u
(defun c:`13()

      ;; (ml2 (entsel "line\n") y2  lay)
      (ml2 (m_ssl) (/ y2 2) (getreal "Num") (nth (atoi (rtos m_lays2)) LayList))
)

  

;; ���I���_
(defun c:`2( / mp ml)

      (setq ml (m_ssl))
      (setq mp (getpoint "point")) 
      ;; (command "break"  (entsel "line") "f" mp mp)
      (command "break"  ml "f" mp mp)
)



 
;; ���I���_
(defun c:`2q( / num ss p1 p2)
      
      (setq ss (ssget)
            p1 (getpoint "1")
            p2 (getpoint "2")
      )
      (setq num (sslength ss))
      (setq x 0)

      (command "._UNDO" "_Begin")
      (repeat num
            
            
            (vl-cmdf  "dimbreak" (ssname ss x) "F"  "M" p1 p2 )
            (setq x (1+ x))
      )

      ;; (vl-cmdf  "dimbreak" (ssget) "F"  "M")
      (command "._UNDO" "_End")
)


;; �е��[t
(defun c:`2w( / ss num x line_data old_spoint new_spoint new_line_data)

      ;; (setq line_data (entget (car (entsel))))
      (setq ss (ssget))
      (setq num (sslength ss))
      (setq x 0)


      (repeat num
          
            (setq line_data (entget  (ssname  ss x) ))

            (cond  ((= (cdr (assoc 0 line_data))  "DIMENSION")
            (progn
            ;; ���
            (setq old_spoint (assoc 1 line_data))
            (setq new_spoint (cons 1 m_str))
            (setq new_line_data (subst new_spoint old_spoint line_data))
            ;; �ϼh
            (setq old_spoint (assoc 8 new_line_data))
            (setq new_spoint (cons 8 "DIM"))
            (setq new_line_data (subst new_spoint old_spoint new_line_data))

            (entmod new_line_data)
            ))

            ((= (cdr (assoc 0 line_data))  "MULTILEADER")
            (progn
            (setq old_spoint (assoc 8 line_data))
            (setq new_spoint (cons 8 "DIM"))
            (setq new_line_data (subst new_spoint old_spoint line_data))
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
 


;; ���_��
(defun c:`22( / mp  mp2 ml)

      (setq ml (m_ssl))
      (setq mp (getpoint "point")) 
      (setq mp2 (list (+ (car mp) 0.000001)  (+ (cadr mp) 0.000001) ))


      ;; (command "break"  (entsel "line") "f" mp mp)
      (command "break"  ml "f" mp mp2)
)

 

;; �ѦҨt
(defun c:`21( )
     
      (command "ucs"  (getpoint  "1\n") (getpoint  "2\n") "" )
      ;; (vl-cmdf "ucs" "" "" "" "" )
      (princ)
)
 

;; �Y��
(defun C:`23()
      (m_scale v_scale)
)


;; �T�I�е�
(defun c:`3( / m1 m2 m3)

      (setq  m1 (getpoint "1\n")  
             m2 (getpoint "2\n")  
             m3  (m_poAdd m2 (m_getVerA (m_poAdd m2 (m_poUn m1)))) ;;(getpoint "3\n") 
      )
     
     
      




      (command "dimlinear" m1 m2 "r" m2 m3 )

)
 
;; �Z��
(defun C:`31()
      (distance (getpoint "1\n") (getpoint "2\n"))

      ;; (setq  a (getpoint "a\n"))
      ;; (setq  b (getpoint "b\n"))
      ;; (setq  c (getpoint "c\n"))
      ;; ;; (command "ELLIPSE" a b c )

)

;; �T�Ixy
(defun c:`32( / m1 m2 m3)

      (setq m1 (getpoint "1") )
      (print  )
      (setq m2 (getpoint "2") )
      (print  )
      (setq m3 (getpoint "3") )
      (print  )

      (list (+ 1 (fix (abs (- (car m1) (car m2))))) (+ 1 (fix (abs (- (cadr m2) (cadr m3))))))

)

;; ��a��
(defun c:`4()
      (m_oriBlock (ssget) (getpoint "po"))
      (princ)
)


;; �[
(defun c:`41()
      (vl-cmdf  "refset" "a" )
      (vl-cmdf  "refset" "r" )
       (princ)
)
 
;; ��
(defun c:`42()
      (vl-cmdf  "refset" "r" )
       (princ)
)
 
;; �h�X


(defun c:`44()
      (vl-cmdf  "refclose"  "s"  )
      (princ)
)



;; �ɱ׼е�Begin , used  posub  poadd  posort
(defun c:xd(   /   p1 p2 p3 p4 vec vec1 isleft isup lst  x1 x2 y1 y2 k m re UL )

      (prompt "�ĤT�I�b�u�q�W�h�е��ɱ׶ɱסA�e���I�ݪ��h����I��V")
      (setq 
            p1  (getpoint "    1")
            p2  (getpoint " 2")
            p4  (getpoint " 3")
            p3  (getpoint " 4")





            buf (m_UL p1 p2 p4)
            UL (cadr buf)
            vec (car buf)
            dx (caddr buf)

            UL1 (cadr (m_UL p1 p2 p3))
            


      )

      (vl-cmdf "_style" "s30" "" "" "" 30 "" "" "")
      (vl-cmdf "_style" "s-30" "" "" "" -30 "" "" "")
      

      (if (not (= dx 0) )
      (cond ((= UL 11 )

                  (if (= UL1 11) 
                        (m_UL1 "s30" p1 p2 p4 vec)
                        (m_UL1 "s30" p1 p2 p3 vec)
                  
                  
                  )
                  )
            ((= UL 00 )
                  
                  (if (= UL1 00)
                        (m_UL1 "s-30" p1 p2 p4 vec)
                        (m_UL1 "s-30" p1 p2 p3 vec)
                  )
                  )
            ((= UL 10 ) 
                  (if (= UL1 10)
                        (m_UL1 "s-30" p1 p2 p4 '(0 1 0))                 
                        (m_UL1 "s-30" p1 p2 p3 '(0 1 0))
                  )
                  )
            ((= UL 01 ) 
                  (if (= UL1 01)
                        (m_UL1 "s30" p1 p2 p4 '(0 1 0))  
                        (m_UL1 "s30" p1 p2 p3 '(0 1 0))
                  )
                  )
      
      
      )
      (progn 
            (setq 
                  lst (list p3 p4)
                  lst (m_poSorX lst)
                  vec (m_posub (nth 0 lst) (nth 1 lst))
                  isleft (if (> (cadr vec) 0)  1 0 )


            )
            (if (= isleft 1)
                  (m_UL1 "s-30" p1 p2 p3 vec)
                  (m_UL1 "s30" p1 p2 p3 vec)
            )

            
      
      )
      
      )

 
      (vl-cmdf "_style" "standard" "" "" "" "" "" "" "")
      (setvar "dimtxsty" "standard")


       
       
      ;; UL
      isleft



)

(defun 3x(  m1 m2 m4 / m3)

      (setq  
            ;;  m1 (getpoint "1\n")  
            ;;  m2 (getpoint "2\n")  
            ;;  m4 (getpoint "4\n")  
             m3  (m_poAdd m2 (m_getVerA (m_poAdd m2 (m_poUn m1)))) ;;(getpoint "3\n") 
      )
     

      (command "dimlinear" m1 m2 "r" m2 m3 m4 )

)

(defun m_UL( p1 p2 p4 / lst vec vec1 isleft isup x1 x2 y1 y2 x y m k re UL dx)

      (setq 
            lst (list p1 p2)
            lst (m_poSorX lst)
            
            ;; isup 1
            ;; isleft 1
            vec (m_posub p1 p2)
            vec (subst (- (nth 1 vec)) (nth 1 vec) vec)


            vec1 (m_posub (nth 0 lst) (nth 1 lst))
            
            isleft (if (> (cadr vec1) 0)  1 0 )
            
            dx (car vec1)



            x1 (car p1)
            x2 (car p2)
            y1 (cadr p1)
            y2 (cadr p2)

            x (car p4)
            y (cadr p4)

            k (/ (- x1 x2) (- y1 y2))
            m (- (+ (- (* k y ) x) x1) (* k y1) )



            isup (if (> m 0) 1 0 )

            re (list isup isleft)
            UL (atof (strcat (itoa (nth 0 re)) (itoa (nth 1 re))))


      )
           (list vec UL dx)
)

(defun m_UL1(st p1 p2 p4 vec / buf)
      (vl-cmdf "_style" st "" "" "" "" "" "" "")
      (setvar "dimtxsty" st)
      (3x p1 p2 p4)
      (setq buf (entlast))
      (vl-cmdf "dimedit" "o"  buf "" p1 (m_poadd p1 vec) )
      
)
;; �ɱ׼е�END





;; �������u
(defun c:m_2cL()  (vl-cmdf "line" "_tan" pause  "_tan" pause "" ))





;; ��X���,��ܿ�ܶ�
;; (sssetfirst nil (ssget "L"))

 
;;======================DETAIL WORK===============================

;; �b�Ӯy
(defun m_made1( / base base2 t1 t2 t3 w1 w2 w3 buf ss )
      (setq base (getpoint "1"))
      ;; (setq base2 (getpoint "2"))
      (setq t1 (distance (getpoint "t1") (getpoint))
            t2 (distance (getpoint "t2") (getpoint))
            t3 (distance (getpoint "t3") (getpoint))

            w1 (distance (getpoint "w1") (getpoint))
            w2 (distance (getpoint "w2") (getpoint))
            w3 (distance (getpoint "w3") (getpoint))
      
      )

 

      (vl-cmdf "rectang" '(0 0) (list w1 t1))
      (vl-cmdf "move" (entlast) "" (list (/ w1 2) 0) '(0 0))
      (setq ss (ssadd (entlast)))


      (vl-cmdf "line" (list 0 (- t1)) (list 0 (+ t1 t3 t1)) "" )
      (m_change (entlast) "C")
      (ssadd (entlast) ss)
       

      (vl-cmdf "rectang" '(0 0) (list w2 t2))
      (vl-cmdf "move" (entlast) "" (list (/ w2 2) (- t1)) '(0 0))
      (ssadd (entlast) ss)


      (vl-cmdf "rectang" '(0 0) (list w3 t3))
      (vl-cmdf "move" (entlast) "" (list (/ w3 2) (- t1)) '(0 0))
      (ssadd (entlast) ss)


      (vl-cmdf "move"  ss ""  '(0 0)  base)



     
      (setq buf (m_blockName))
      (vl-cmdf "-block"  buf base ss "" )
      (vl-cmdf "-insert" buf base "" "" ""  )






      (princ)


)

;; �ֱa�D��
(defun m_made2( / len side mid buf buf1 buf2 buf3 ss ss1 num x m1 m2 m3 p1 p2)

      ;; (setq len (getreal "len"))
      (setq len (getreal "len\n");;(distance (getpoint "len") (getpoint))
            m1 (getreal "m1\n");;(distance (getpoint "m1") (getpoint))
            m2 (getreal "m2\n");;(distance (getpoint "m2") (getpoint))
            m3 (getreal "m3\n");;(distance (getpoint "m3") (getpoint))
            p1 (getpoint "p1")
            p2 (getpoint "p2")
      )

      (setq side (getpoint "po"))

      (setq mid (m_poAdd side (list 0  (/ len 2))) )


      (setq buf (ssget)
            ss (ssadd)   
            ss1 (ssadd)   
      )
      (m_ssAdd buf ss)

      (setq buf1 (m_blockName))
      (vl-cmdf "-block"  buf1 mid ss "" )
      (vl-cmdf "-insert" buf1 mid "" "" ""  )
      (setq buf3 (entlast))
      (ssadd buf3 ss1)


      




      (vl-cmdf "mirror" buf3 "" mid  (m_poAdd mid (list 1 0) ) ""  )
      (ssadd (entlast) ss1)

      (vl-cmdf "line" (m_poAdd mid (list (- len) 0) ) (m_poAdd mid (list len 0) ) "" )
      (setq buf2 (entlast) )
      (command  "change" buf2 "" "p" "la"  "C"  "")
      (ssadd buf2 ss1)






      (m_ssAdd (ml (list buf2 (list 0 0 0))  0 100  (/ m1 2) "0" ) ss1)
      (m_ssAdd (ml (list buf2 (list 0 0 0))  0 100  (/ m2 2) "C" ) ss1)
      (m_ssAdd (ml (list buf2 (list 0 0 0))  0 100  (/ m3 2) "C" ) ss1)



      (vl-cmdf "line" (list (car p1) (+ (cadr mid) (/ m3 2))  )  (list (car p1) (+ (cadr mid) (- (/ m3 2)))  ) "" )
      (setq buf2 (entlast) )
      (command  "change" buf2 "" "p" "la"  "C"  "")
      (ssadd buf2 ss1)

      (vl-cmdf "line" (list (car p2) (+ (cadr mid) (/ m3 2))  )  (list (car p2) (+ (cadr mid) (- (/ m3 2)))  ) "" )
      (setq buf2 (entlast) )
      (command  "change" buf2 "" "p" "la"  "C"  "")
      (ssadd buf2 ss1)

      ;; (vl-cmdf "xline" "v" p1 p2 "" )
 



      (setq buf1 (m_blockName))
      (vl-cmdf "-block"  buf1 mid ss1 "" )
      (vl-cmdf "-insert" buf1 mid "" "" ""  )



      (princ)
)

;; �b�Ӯy
(defun m_made3( / base w1 w2 w3 h1 h2 h3  d3 ss buf )

      (setq base (getpoint "1"))
   
      (setq 
            ;; w1 (distance (getpoint "w1") (getpoint))
            w2 (distance (getpoint "w2") (getpoint))
            w3 (distance (getpoint "w3") (getpoint))
            d3 (distance (getpoint "d3") (getpoint))


            ;; h1 (distance (getpoint "h1") (getpoint))
            h2 (distance (getpoint "h2") (getpoint))
            h3 (distance (getpoint "h3") (getpoint))

      )

 

      ;; (vl-cmdf "rectang" '(0 0) (list w1 h1))
      ;; (vl-cmdf "move" (entlast) "" (list (/ w1 2) (/ h1 2)) '(0 0))
      ;; (setq ss (ssadd (entlast)))
      

      (vl-cmdf "rectang" '(0 0) (list w2 h2))
      (vl-cmdf "move" (entlast) "" (list (/ w2 2) (/ h2 2)) '(0 0))
      (setq ss (ssadd (entlast)))

      (vl-cmdf "rectang" '(0 0) (list w3 h3))
      (vl-cmdf "move" (entlast) "" (list (/ d3 2) (/ h3 2)) '(0 0))
      (ssadd (entlast) ss)

      (vl-cmdf "mirror" (entlast) "" '(0 0)  '(0 1)""  )
      (ssadd (entlast) ss)

      (vl-cmdf "line" (list 0 (- (* h2 0.6 ))) (list 0 (+ (* h2 0.6 ) )) "" )
      (m_change (entlast) "C")
      (ssadd (entlast) ss)

      (vl-cmdf "line" (list  (- (* w2 0.6 )) 0) (list  (+ (* w2 0.6 )) 0) "" )
      (m_change (entlast) "C")
      (ssadd (entlast) ss)


      (vl-cmdf "move"  ss ""  '(0 0)  base)     
      (setq buf (m_blockName))
      (vl-cmdf "-block"  buf base ss "" )
      (vl-cmdf "-insert" buf base "" "" ""  )

)

;; ���}�u
(defun m_made4( / base theta1 theta2 ntheta dtheta buf buf1 buf2 co x co2 buf3 co3  alp2  )

      (setq base (getpoint "base")
            r 100 ;;(getreal "r" )
            theta1  0.00 ;;(getreal "theta1")
            theta2  360.0 ;;(getreal "theta2")
            ntheta  100 ;;(getreal "ntheta")
            dtheta (/ (- theta2 theta1) ntheta)
            buf 0.00  
            buf2 (list )
            buf3 (list )
      )


      (repeat  (+ ntheta 1)
            (setq buf1 (+ buf theta1)

                  co3 (m_maAng buf1)
                  co (list (* r (cos co3)) (* r (sin co3)))
                  

                  alp2  (* r co3) 
                  

                  co2  (m_getVerA co)
                  co2 (m_poSca co2 alp2 )
                  buf3 (append buf3 (list co2) )

                  co (m_poAdd co base)
                  buf2 (append buf2 (list co) )



            )
             
            ;; (princ  (strcat  (rtos buf1) "\n") ) 
            (setq  buf (+ buf dtheta) )
      )

 

 

      (setq x 0)
      (repeat  ntheta 

            ;; (command "line" (nth x buf2)  (nth (+ x 1) buf2) "")
            (command "line" (m_poAdd (nth x buf2) (nth  x  buf3)) 
             (m_poAdd (nth (+ x 1) buf2) (nth  (+ x 1)  buf3)) "")

            ;; (command "line" base  (nth x buf2) "")
            (setq x (+ 1 x))
      )
      

      (command "circle" base r )

      (princ)

)

;; ���I�u�զX
(defun m_made5 ( / base buf ss Lss Lbuf )


      (setq base (getpoint "base")
            ss (ssadd)

            buf (m_Midli base '(1000 0))
            Lss (ssadd (entlast) ss)
            Lbuf (vl-cmdf "line" (car buf) (m_poAdd (car buf) (list 0 -200)) "")
            Lss (ssadd (entlast) ss)
            Lbuf (vl-cmdf "line" (cadr buf) (m_poAdd (cadr buf) (list 0 -200)) "")
            Lss (ssadd (entlast) ss)

            buf (m_Midli (m_poAdd base (list 0 200)) (list 800 0))
            Lss (ssadd (entlast) ss)
            Lbuf (vl-cmdf "line" (car buf) (m_poAdd (car buf) (list 0 -200)) "")
            Lss (ssadd (entlast) ss)
            Lbuf (vl-cmdf "line" (cadr buf) (m_poAdd (cadr buf) (list 0 -200)) "")
            Lss (ssadd (entlast) ss)

            buf (m_Midli (m_poAdd base (list 0 400)) (list 600 0))
            Lss (ssadd (entlast) ss)
            Lbuf (vl-cmdf "line" (car buf) (m_poAdd (car buf) (list 0 -200)) "")
            Lss (ssadd (entlast) ss)
            Lbuf (vl-cmdf "line" (cadr buf) (m_poAdd (cadr buf) (list 0 -200)) "")
            Lss (ssadd (entlast) ss)

            Lbuf (vl-cmdf "line"  (m_poAdd base (list 0 -300))  
                  (m_poAdd (m_poAdd base (list 0 400)) (list 0 100)) "")
            Lss (ssadd (entlast) ss)
            Lbuf (m_change (entlast) "c")

            buf (m_blockName)

      

      )

      

      (vl-cmdf "-block"  buf base ss "" )
      (vl-cmdf "-insert" buf base "" "" ""  )


 


)


;; �׼�
(defun m_made6 ( / l1 l2 fi vec1 vec2 vec3 p1 p2 p3 p4 p5 buf buf2 ss ss1 )

      (setq 
            ss (ssadd)
            ss1 (ssadd)
            l1 220 ;;��
            l2 100  ;;�e    
            l3 50
            fi 20

            ;; �����V
            buf (m_getTwopoint (m_ssl))
            vec1 (m_poAdd (cadr buf)  (m_poUn (car buf)))

            ;; �w���Y��
            vec1 (m_poSca vec1 l1)
            vec3 (m_poSca vec1 l3)
            ;; �_�I


            ;; ���u��V
            vec2 (m_getVerA vec1)

            ;; �w���Y��
            vec2 (m_poSca vec2 (/ l2 2))


            ;; �_�I
            p1 (m_poAdd (car buf) vec2) 
            p2 (m_poAdd (car buf) (m_poUn vec2))

            buf2 (vl-cmdf "line"  p1 p2 "")
            buf2 (ssadd (entlast) ss )

            p3 (m_poAdd p1 vec1)
            p4 (m_poAdd p2 vec1)


            buf2 (vl-cmdf "line"  p1 p3 "")
            buf2 (ssadd (entlast) ss )

            buf2 (vl-cmdf "line"  p2 p4 "")
            buf2 (ssadd (entlast) ss )

            buf2 (vl-cmdf "line"  p3 p4 "")
            buf2 (ssadd (entlast) ss )

            p5 (m_poAdd (car buf) vec3)
            buf2 (vl-cmdf "circle"  p5 (/ fi 2) )
            buf2 (ssadd (entlast) ss )


            
            buf2 (m_ssAdd  (m_centCrossa p5 vec1 (* fi 1.5))  ss  )

             

            ;; ���I
            p1 (m_poAdd (cadr buf) vec2) 
            p2 (m_poAdd (cadr buf) (m_poUn vec2))

            buf2 (vl-cmdf "line"  p1 p2 "")
            buf2 (ssadd (entlast) ss1 )

            p3 (m_poAdd p1 (m_poUn vec1))
            p4 (m_poAdd p2 (m_poUn vec1))


            buf2 (vl-cmdf "line"  p1 p3 "")
            buf2 (ssadd (entlast) ss1 )

            buf2 (vl-cmdf "line"  p2 p4 "")
            buf2 (ssadd (entlast) ss1 )

            buf2 (vl-cmdf "line"  p3 p4 "")
            buf2 (ssadd (entlast) ss1 )


            p5 (m_poAdd (cadr buf)  (m_poUn vec3))
            buf2 (vl-cmdf "circle"  p5 (/ fi 2) )
            buf2 (ssadd (entlast) ss1 )

            buf2 (m_ssAdd  (m_centCrossa p5 vec1 (* fi 1.5))  ss1  )

      )

      (m_oriBlock ss (car buf))
      (m_oriBlock ss1 (cadr buf))



      (princ)

)



;; �I�洫 ���I
(defun m_2poSwap(p1 p2)
      (list p2 p1)
)


 
;;��ø�s

(defun m_pipeSplite(p1 p2 p3 lay / )
  
      centLine (vl-cmdf "line"   (m_poAdd p1 p3)   (m_poAdd p2 p3)   "" )
      (m_change (entlast) lay)

)


;; �V�Uø�s��
(defun m_pipeDown( line fi1 fi2 /  LineDate centLine change vec vecVer p1 p2 )

      (setq 
            ;; line (m_ssl)
            LineDate (m_getTwopoint line)
            ;; fi1 100 ;;(getreal "fi1" )
            ;; fi2 5 ;;(getreal "fi2" )

            p1  (car LineDate)  
            p2  (cadr LineDate)  
            

            ;; �洫
            centLine (if (< (car p2) (car p1) )
                  (m_2poSwap p1 p2)
                  (list p1 p2)
            )
             
            p1 (car centLine)
            p2 (cadr centLine)


            vec (m_getVec p1 p2)
            vecVer (m_getVerA vec) ;;���ɰw

             


            ss (ssadd)
            ;;42.7 4.9

            ;;������u�I
            p3 (m_poSca vecVer (/ fi1 2) )
            p1  (m_poAdd p1 p3)
            p2  (m_poAdd p2 p3)





            p3 '(0 0)
            centLine (m_pipeSplite p1 p2 p3 "C")


            p3 (m_poSca vecVer (/ fi1 2) )
            centLine (m_pipeSplite p1 p2 p3 "0")



            p3 (m_poSca vecVer (/ (- fi1  (* fi2 2)) 2) )
            centLine (m_pipeSplite p1 p2 p3 "D")



            p3 (m_poUn p3)
            centLine (m_pipeSplite p1 p2 p3 "D")



      
      )



)
(defun m_pipeDownEx( fi1 fi2 / line num x )
      (setq line (ssget)
            num (sslength line)
            x 0
      )
      
      (repeat num
            (m_pipeDown (m_sslN (ssname  line x )) fi1 fi2)
            (setq x (+ x 1))
      )


)
 
;; ������
(defun m_pipeOff( line  fi1 fi2 / LineDate p1 buf buf2 p2 p3 )

      (setq 
            ;; line (m_ssl)
            LineDate (m_getDataA line)
            p1 (cdr (assoc 10 LineDate))
            buf (m_rand 1000)
            buf2 (m_rand 1000)

            ;; fi1 100  ;;(getreal "fi1" )
            ;; fi2 5  ;;(getreal "fi2" )



            p2 (m_poAdd p1 (list (+ buf) (+ buf2) ) )
            p3 (m_poAdd p1 (list (- buf) (- buf2) ) )
      )

       
      (vl-cmdf "offset" (/ fi1 2)  line p2 "")
      (m_change (entlast) "0")
      (vl-cmdf "offset" (/ fi1 2)  line p3 "")
      (m_change (entlast) "0")


      ;;���p2 p3
      (setq 
            buf (m_rand 1000)
            buf2 (m_rand 1000)
            p2 (m_poAdd p1 (list (+ buf) (+ buf2) ) )
            p3 (m_poAdd p1 (list (- buf) (- buf2) ) )
            )

      (vl-cmdf "offset" (/ (- fi1 (* fi2 2)) 2)  line p2 "")
      (m_change (entlast) "D")
      (vl-cmdf "offset" (/ (- fi1 (* fi2 2)) 2)  line p3  "")
      (m_change (entlast) "D")
      


      (m_change line "C")
    
      (princ )

)
(defun m_pipeOffEx (fi1 fi2 / line num x )

      (setq line (ssget)
            num (sslength line)
            x 0
      )
      
      (repeat num
            (m_pipeOff (m_sslN (ssname  line x )) fi1 fi2)
            (setq x (+ x 1))
      )
)



;; �騤�Ԧ��A�˨�
;; �����Ť�

(defun m_pipeTrim( w p )

      (cond ((= 6 w)(m_pipeTrim6 p))
            ((= 8 w)(m_pipeTrim8 p))
      
      )

)



;; ���I��4�I
(defun m_2poTo4l(p1 p2)

      (list p1  (list (car p1) (cadr p2))   p2 (list (car p2) (cadr p1)) )

)

;; t��e�I
(defun m_pipeTrim6( p / b b2 buf a off ss ss1 a1 b1 off1 )

      (setq 

            b (getpoint "base")
            buf (m_poUn b)

            a (list  
                  (getpoint "1")
                  (getpoint "2")
                  (getpoint "3")
                  (getpoint "4")
                  (getpoint "5")
                  (getpoint "6")
            
            )
            b (list  buf  buf buf  buf buf  buf )

            a1 (list
                  (getpoint "a1")
                  (getpoint "a2")
                  (getpoint "a3")
            )
            b1 (list  buf buf buf )

            off1 (mapcar 'm_poAdd a1 b1)
            off (mapcar 'm_poAdd a b)


             
            
            ss1 (list 
                  (ssget "F"  (list (nth 0 a) (nth 1 a))  
                  '((-4 . "<not")(8 . "C")(-4 . "not>")) )

                  (ssget "F"  (list (nth 2 a) (nth 3 a))
                  '((-4 . "<not")(8 . "C")(-4 . "not>")))

                  (ssget "F"  (list (nth 4 a) (nth 5 a))
                  '((-4 . "<not")(8 . "C")(-4 . "not>")))
            )

            buf (command "spline"  (nth 0  a1) (nth 1  a1) (nth 2  a1) "" "" "")
            ss (entlast)


            buf (vl-cmdf "trim" ss ""  (nth 0 ss1) "")
            buf (vl-cmdf "trim" ss ""  (nth 1 ss1) "")
            buf (vl-cmdf "trim" ss ""  (nth 2 ss1) "")
                

      )

      (repeat (- p 1)
      (setq
      
            b2 (getpoint "base2")
            b (list   b2 b2 b2 b2 b2 b2 )
            b1 (list b2  b2 b2 )

            a1 (mapcar 'm_poAdd off1 b1)
            a (mapcar 'm_poAdd off b)

            ss (ssadd)
            ss1 (list 
                  (ssget "F"  (list (nth 0 a) (nth 1 a))  
                  '((-4 . "<not")(8 . "C")(-4 . "not>")) )

                  (ssget "F"  (list (nth 2 a) (nth 3 a))
                  '((-4 . "<not")(8 . "C")(-4 . "not>")))

                  (ssget "F"  (list (nth 4 a) (nth 5 a))
                  '((-4 . "<not")(8 . "C")(-4 . "not>")))
            )


            buf (command "spline"  (nth 0  a1) (nth 1  a1) (nth 2  a1) "" "" "")
            ss (entlast)

            buf (vl-cmdf "trim" ss ""  (nth 0 ss1) "")
            buf (vl-cmdf "trim" ss ""  (nth 1 ss1) "")
            buf (vl-cmdf "trim" ss ""  (nth 2 ss1) "")
            
      )
      )

      (princ )
)

;; ��e�I
(defun m_pipeTrim8( p /  
      a b a1 b1   off off1 ss ss1  buf x
      )

       
 


      (setq 




            b (getpoint "base")
            buf (m_poUn b)  ;;�T�I
            buf (append buf '(0))

            a (m_lsTps)  ;;�T�I
            b (m_poRep buf 8)  ;;�I

            a1 (list      ;;�T�I
                  (getpoint "a1")
                  (getpoint "a2")
                  (getpoint "a3")
                  (getpoint "a4")
                  (getpoint "a5")            
            )
            b1 (m_poRep buf 5)

            off1 (mapcar 'm_poAdd a1 b1)
 
             
            
            ss (ssadd)
            ss1 (m_poTss a)


            buf (vl-cmdf "spline"  (nth 0  a1) (nth 1  a1) (nth 2  a1) "" "" "")
            buf (ssadd (entlast) ss)
            buf (vl-cmdf "spline"  (nth 3  a1) (nth 1  a1) (nth 4  a1) "" "" "")
            buf (ssadd (entlast) ss)


            off (mapcar 'm_poAdd a b)
            x 0
      )

      (repeat (length ss1)
            (vl-cmdf "trim" ss ""  (nth x ss1) "")
            (setq x (+ x 1))
      )


      ;; ==========================

      (repeat (- p 1)
      (setq 
            b2 (getpoint "base2")

            b (m_poRep b2 8)
            b1 (m_poRep b2 5)


            a1 (mapcar 'm_poAdd off1 b1)




            a (mapcar 'm_poAdd off b)

            ss (ssadd)
            ss1 (m_poTss a)

 

            buf (vl-cmdf "spline"  (nth 0  a1) (nth 1  a1) (nth 2  a1) "" "" "")
            buf (ssadd (entlast) ss)
            buf (vl-cmdf "spline"  (nth 3  a1) (nth 1  a1) (nth 4  a1) "" "" "")
            buf (ssadd (entlast) ss)
            x 0

            
 
      )

      (repeat (/ (length a) 2)
      
            (vl-cmdf "line" (nth x a) (nth (1+ x ) a) "")
            (setq x (+ 2 x))
      )

      (setq x 0)

      (repeat (length ss1)
            (vl-cmdf "trim" ss ""  (nth x ss1) "")
            (setq x (+ x 1))
      )



      )
      (princ a)
      (princ ss1 )
)

;; ���I���@�� �ϥ�m_selF ��^n/2
(defun m_poTss( a /  ss1 x )

      (setq 
            ss1 (list )
            x 0
      )

      
      (repeat (/ (length a) 2)

            (setq 
            ss1 (append  (list (m_selF (nth x a) (nth (+ 1 x) a) )) ss1)
            x (+ x 2)
            )
      )

      ss1

)

;; �騤
(defun m_pipeTrim2( fi1 theta / p a1 a2 midfi fi2)


      (setq 
      
            p (m_lsTps)

            a1 (m_selF1 (nth 0 p) (nth 1 p))
            a2 (m_selF1 (nth 2 p) (nth 3 p))

            
            ;; fi1 100
            ;; theta 5
            midfi (+ (* fi1 0.1) (/ fi1 2))
            fi2  (- fi1 (* theta 2))


      )


      (vl-cmdf  "fillet" (ssname  a1 0) "r" (+ midfi (/ fi1 2)) (ssname a2 0))
      (vl-cmdf  "fillet" (ssname  a1 1) "r" (+ midfi (/ fi2 2)) (ssname a2 1))
      (vl-cmdf  "fillet" (ssname  a1 2) "r" midfi (ssname  a2 2))
      (vl-cmdf  "fillet" (ssname  a1 3) "r" (- midfi (/ fi2 2)) (ssname  a2 3))
      (vl-cmdf  "fillet" (ssname  a1 4) "r" (- midfi (/ fi1 2)) (ssname  a2 4))

)

;; T��
(defun m_pipeTrim3( / fi1 fi2  p1 p2 p3  p4 p5 dis vec )
      ;; fi1 > fi2
      (setq 
            ;; fi1 100 ;;�i�p��
            ;; fi2  80 ;;�i�p��
             
            

            p4 (gp)
            p1 (gp)
            p5 (gp)


            vec (m_posub p4 p5)
            vec (m_poScaSC vec 0.5)
            pm (m_poadd p4 vec)

            p2 pm
            fi1  (* (distance p1 p2) 2) 
            fi2  (distance p4 p5) 



            dis  (sqrt (- (expt (/ fi1 2) 2 ) (expt (/ fi2 2) 2 )))
            vec (m_posub p1 p2)
            vec (m_poSca vec dis)
            
            p3 (m_poadd p1 vec)
            
      )

      (vl-cmdf "spline" p4 p3 p5 "" "" "")


      ;; (m_tc (list p3) )

)


;; ��� ----------
(defun m_FY()

      (setq r 100.0
            a 300.0
            d 100.0
            n 6
            dtheta (/ 90.0 n)
      )






)

 

;; �t�X�]�m,��r �奻 ����
 
 
(defun q(p f n n1 n2 n3 n4 / ) 

            ;;   ""  "one"  1 1 1 "1-" 1
      (setq word p
            fna (strcat f ".txt")
            con n 
            alp1 n1
            alp2 n2

            m_S n3
            m_V n4
      )
)

;; �@��
(defun C:q( / fpa  fpna fp re1 re2 re3 buf buf2 )
      (setq fpa "E:\\ZCM\\ALL\\"
            ;; fna "one.txt"
            fpna (strcat fpa fna)
            re1  word;;(getstring )
            ;; alp 1.030747
      )

      
      (cond ((= con 1) (progn
                  (setq 
                  p1 (gp)
                  p2 (gp)
                  buf (vl-cmdf "dimlinear" p1 p2 "r" p1 p2  pause )

                  
                  buf (rtos (cdr (assoc 42 (entget (entlast)))) 2 2)
                  buf2 (entdel (entlast))


                  re2  buf;;(rtos (getreal) 2 2)
                  re3 (strcat re1 " :  " re2  
                  "   " (strcat m_S (itoa m_V)) 
                  "\n")
                  )

            ))
            ((= con 2) (progn
                  (setq 
                  p1 (gp)
                  p2 (gp)
                  buf (vl-cmdf "dimlinear" p1 p2 "r" p1 p2  pause )
                  buf (rtos (cdr (assoc 42 (entget (entlast)))) 2 2)
                  buf2 (entdel (entlast))


                  re2  buf;;(rtos (getreal) 2 2)

                  p1 (gp)
                  p2 (gp)
                  buf (vl-cmdf "dimlinear" p1 p2 "r" p1 p2  pause )
                  buf (rtos (cdr (assoc 42 (entget (entlast)))) 2 2)
                  buf2 (entdel (entlast))

                  re4 buf


                  re3 (strcat re1 " :  " re2  "x" re4  
                  "   " (strcat m_S (itoa m_V)) 
                  "\n")
                  )

            ))
            ((= con 11) (progn
                  (setq 
                  

                  p1 (gp)
                  p2 (gp)
                  buf (vl-cmdf "dimlinear" p1 p2 "r" p1 p2  pause )


                  buf (rtos (* alp1 (cdr (assoc 42 (entget (entlast))))) 2 2)
                  buf2 (entdel (entlast))


                  re2  buf;;(rtos (getreal) 2 2)
                  re3 (strcat re1 " :  " re2  
                  "   " (strcat m_S (itoa m_V)) 
                  "\n")
                  )

            ))
            ((= con 21) (progn

                  (setq 
                  p1 (gp)
                  p2 (gp)
                  buf (vl-cmdf "dimlinear" p1 p2 "r" p1 p2  pause )
                  buf (rtos (* alp1 (cdr (assoc 42 (entget (entlast))))) 2 2)
                  buf2 (entdel (entlast))


                  re2  buf;;(rtos (getreal) 2 2)

                  p1 (gp)
                  p2 (gp)
                  buf (vl-cmdf "dimlinear" p1 p2 "r" p1 p2  pause )
                  buf (rtos (* alp2 (cdr (assoc 42 (entget (entlast))))) 2 2)
                  buf2 (entdel (entlast))

                  re4 buf

                  re3 (strcat re1 " :  " re2  "x" re4  
                  "   " (strcat m_S (itoa m_V)) 
                  "\n")
                  )

            ))
      
      )
 

      ;; r,w,a
      (setq fp (open fpna "a")
            m_V (1+ m_V) 
      )
      (if (findfile fpna) (princ "TURE") (princ "FALSE") )
      (princ re3 fp)
      (close fp)
      (princ )
)



(defun c:`mLable( / cp0 p p0  p1 p2 v ss buf )

      (setq p (gp)
            
            cp0 (* 3 v_scale -0.5)
 
            ;; �Ѧ��Iø�s
            ss (ssadd)
            buf (vl-cmdf "line" 
                  (m_poAdd p (list cp0 0 0))
                  (m_posub  (list cp0 0 0) p) "")
            buf (ssadd (entlast) ss)
            buf (vl-cmdf "line" 
                  (m_poadd p (list 0 cp0 0))
                  (m_posub  (list 0 cp0 0) p) "")
            buf (ssadd (entlast) ss)




            p0 (gp)
            buf (vl-cmdf  "erase" ss "")


            v (strcat m_S (itoa m_V))
            p1 (m_poAdd  p '(6.5 0 0))
            p2 (m_poAdd  p '(0 2.5 0))

            ss (ssadd)
            ;; buf (vl-cmdf "ATTDEF" "" v   ""  ""  "j" "m" p 3   "" )
            buf (vl-cmdf "text" "j" "m" p 3 ""  v)
            buf (ssadd (entlast) ss)
            buf (vl-cmdf "ELLIPSE" "c" p p1 p2)
            buf (ssadd (entlast) ss)


            buf (vl-cmdf "ROTATE" ss "" p p0 )
            buf (vl-cmdf "scale" ss "" p v_scale  )
            buf (m_change ss "DIM")

            m_V (1+ m_V )

      )
    




)
 

(defun c:`mLable2( /  p p0  p1 p2 v ss buf )

      (setq p (gp)
            ;; p0 (gp)
            v (strcat m_S (itoa m_V))
            p1 (m_poAdd  p '(4 0 0))
            p2 (m_poAdd  p '(0 2.5 0))

            ss (ssadd)
            buf (vl-cmdf "ATTDEF" "" v   ""  ""  "j" "m" p 3   "" )
            buf (ssadd (entlast) ss)
            buf (vl-cmdf "circle" "c" p p1 )
            buf (ssadd (entlast) ss)


            ;; buf (vl-cmdf "ROTATE" ss "" p p0 )
            buf (vl-cmdf "scale" ss "" p v_scale  )
            buf (m_change ss "DIM")
            m_V (1+ m_V )
      )
    




)


 

;; (sssetfirst nil (ssget "L"))


;; �I��
(defun m_hT( h b s t1 r / alp area area1 area2)
      ;; kg/mm
      
      (setq 
            alp ( / 156.1 151.5)
            r (if (= nil r) (/ b 10) r)
            area1 (+ (* 2 b t1) (* s (- h t1 t1)) )
            area2 (+ (* 2 b t1) (* s (- h t1 t1)) (* (- 4 pi) r r )  )

            area (if (= nil r) 
            (*  area1 0.000001 7.85  alp  ) 
            (*  area2 0.000001 7.85))
            ;; (* (+ (* 2 b t1) (* s (- h t1 t1)) (* (- 4 pi) r r )  )  0.000001 7.85))

      )



      (princ area)
      (princ   "kg/mm\n")
      (princ )
)


(defun m_fT(h b t1)

      (setq 
            alp (/ 35.82 36.5496)
            area (* (- (* h b)  (* (- h (* 2 t1)) (- b (* 2 t1))))  0.000001 7.85 alp   )
      )


      (princ area)
      (princ   "kg/mm\n")
      (princ )

)
 
;; 0.0365496kg/mm

(defun c:ca()

      (setq alp (/  d1_c9 d1_c10)
            re (* alp (getreal ))
      )


)






(defun c:talx(  / flag  ss p0 x num dp p ss_data old_layer new_layer new_data)
 
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


 
;; (apply 'vl-cmdf (list "line"  (gp)  (gp)  "" ))

(defun pm( / re a )

      (setq re '())
      (while  (setq a (gp)) 
            (setq re (append (list a) re))
      )
      re
)

(defun fm(p1 p2)

      ;;(apply 'vl-cmdf (list "line"  (gp)  (gp)  "" ))
      (apply 'vl-cmdf (append (list p1) p2 ))

)




(if (not (=  (substr (ver) 1 11) "Visual LISP")) (load "acad2014doc.lsp"))

;; Silent load.
(princ)


 




