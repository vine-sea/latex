# Something About CAD

## 參考網址
https://help.autodesk.com/view/OARX/2018/CHS/?pl=ENU   
https://autocadtips1.com/   
https://space.bilibili.com/34873054/channel/seriesdetail?sid=1403894\  


## 基本變量

```lisp
1.23     ;;實數   
'(1 2 3)    ;;(實數的集合) 
(list 1 2 3)   ;;(實數的集合) 
 ```  

## 獲取命令
```lisp
(getreal  "[提示]")   ;; 輸入實數  
(getpoint  "[提示]")    ;; 輸入點  
(ssget )   ;;多選  
(ssname (ssget ) 0)     ;;第一圖元名   
(entget (ssname (ssget ) 0))    ;;圖元信息(獲取表)
```

## 變量賦值
```lisp
(setq a (getpoint "第一點")  b (getpoint "第二點") )   ;; 輸入點  
(setq a (entget (ssname (ssget ) 0)) ) ;;圖元信息(獲取表)
```


## 基本繪製
```lisp
(vl-cmdf "line" a b "")   ;;直線
(vl-cmdf "circle" c 20 )   ;;園
(vl-cmdf "text" "j" "m"  (getpoint "中心點") 3  0 "文本") ;;文本
```

## 基本操作
```lisp
(vl-cmdf "break" (ssget) (setq a (getpoint "打斷點")) a )  ;;一點打斷  
```



## 基本運算
```lisp
(+ 3 2)    ;;加    
(- 3 2)   ;;減   
(* 3 2)    ;;乘   
(/ 3 2)   ;;除   
```

## 基本函數定義
圖形的本質是表
```lisp
(defun getD(a n)(entget (ssname a n)))   ;; 獲取表

(defun newD(a n b / ) (setq b2 (cdr (assoc n a))) (subst (cons n b) (assoc n a) a))  ;;  更新表

(defun dealDex(a b) (vl-remove-if-not '(lambda (buf) (member (car buf) b ) ) a ))   ;;  篩選表(保留)

(defun dealDex2(a b) (vl-remove-if '(lambda (buf) (member (car buf) b ) ) a ))   ;;  篩選表(去除)

(entmod a) ;;更新圖  

(entmakex a) ;;新建圖  
```


## 點運算封裝
```lisp
(apply '+ '(1 2 3))   ;;  累加 
(mapcar '+ a b)   ;;  對應相加 
(mapcar 'sub2 (mapcar '+ a b) )    ;;  對應相加再除以2(計算中點) 
(defun sub2( a / ) (/ a 2) )     ;;固定除以2  
(defun unNum(a / ) (- a))  ;;取反  
(defun sign( a / re) (if (= 0 a) (setq re 0)  (if (< 0 a) (setq re 1) (setq re -1) ) ))    ;;符號函數 
(defun vert( a / re)   (if (or (= 0 (car a)) (= 0 (cadr a)) )  (setq a (mapcar 'sign a))) (setq re (list (nth 1 a) (- (nth 0 a)) 0)))   ;;獲取向量垂直向量 
(defun pointadd (a b) (mapcar '+ a b))  ;;  加 
(defun pointsub (a b) (mapcar '- a b))  ;;  減 
(defun pointun(a) (mapcar 'unNum a))  ;;  點(向量)取反 
```


## 邏輯判斷
```lisp
(if (not (= nil (setq r (getreal "輸入半徑")))) (vl-cmdf "circle" c r ) )    ;;if
```


## 循環獲取,繪製
```lisp
(while (not (= nil (setq r (getreal "輸入半徑"))))  (vl-cmdf "circle" c r ) )    ;;while

(while (not (= nil (and (setq a (getpoint "第一點")) (setq b (getpoint "第二點")) )))  (vl-cmdf "line" a b "") )   ;;while

(repeat 6  (if (= nil a) (setq a (getpoint "中心點")) (setq a (mapcar '+ a '(0 -7 0)))  )  (vl-cmdf "text" "j" "m"  a 3  0 "文本"))  ;;repeat 一列6文本
```
