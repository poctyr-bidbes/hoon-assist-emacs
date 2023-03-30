(require 'json)
(require 'shr)

(global-set-key (kbd "<f7>") 'get-token-definition)
(setq dict-file "/home/mbc/projects/hoon-assist-emacs/hoon-dictionary.json")

(defun json-to-list (json lst)
  (if (cdr json)      
      (progn
	(setq lst (cons  (cons (car (gethash "keys" (car json))) (gethash "doc" (car json))) lst))      
	(json-to-list (cdr json) lst))
    (setq lst (cons  (cons (gethash "keys" (car json)) (gethash "doc" (car json))) lst))))

(defun make-ht-recurse (lst aa)
  ;;lst is the list created by alldefs; aa is the (empty) hash table
  (if (cdr lst)      
      (progn
        (puthash (caar lst) (cdar lst) aa)       
	(make-ht-recurse (cdr lst) aa))
    (progn
      (puthash (caar lst) (cdar lst) aa)
      aa)))

(setq alldefs
  ;;note that json is a list of hash tables
  (let* ((json-object-type 'hash-table)
	 (json-array-type 'list)
	 (json-key-type 'string)
	 (json (json-read-file dict-file))
	 (mylist (json-to-list json '()))
	 (aa (make-hash-table :test 'equal :size 10))
	 (bb (make-ht-recurse mylist aa)))  
    bb))

(defun prep-foo-buffer (html)
  (progn
   (if (get-buffer "*html*")(kill-buffer "*html*"))
   (generate-new-buffer "foo")
   (with-current-buffer "foo" (erase-buffer))
   (with-current-buffer "foo" (goto-char 0))
   (with-current-buffer "foo" (insert (format "%s" html)))
   (shr-render-buffer "foo")
   (kill-buffer "foo")
 ;  (split-window-right)
;   (set-window-buffer nil "*html*")
 ;  (other-window 1)
   ))

;;(window-list)

(defun get-token-definition ()
  (interactive)
  ;; (condition-case nil
  (if (get-buffer "*html*")
      (progn
	(delete-window)
	(kill-buffer "*html*"))	   
      (let* ((current-loc (point))
	     (before-space (re-search-forward "[ (\n]" nil nil -1))
	     (dummy (goto-char current-loc))
	     (after-space (re-search-forward "[ (\n]" nil nil 1))
	     (aa (string-trim (buffer-substring-no-properties  before-space  (- after-space 1) )))
	     (def (gethash aa alldefs)) ;;gets the definition      
	     )
	(if (eq nil def) 
	    (message "%s %s" aa "is not in the dictionary!")
	  (prep-foo-buffer def))
      )
  ;;  (error nil)
    ))



;; (defun process-json-old (json newlst)
;;   (if (cdr json)      
;;     (progn
;;       (setq newlst (cons  (car json) newlst))	    
;;       (process-json (cdr json) newlst))
  
;;     (setq newlst (cons (car json) newlst))
;;     ))


;; (let* ((a '(1 2 3 4))
;;        (b (process-json a '()))
;;        (dummy (prep-foo-buffer))
;;        )
;; (with-current-buffer "foo" (insert  (format "%s" b)))
;;   )

(defun mbc-print-hash (hashtable)
  "Prints the hashtable, each line is key, val"
  (maphash
   (lambda (k v)
     (insert "key:  ")
     (insert (format "%s" k))
     (insert "\n")
     (insert "val:  ")
     (insert (format "%s" v))
     (insert "\n\n------------------------\n")
     )
   hashtable
   ))



(defun pp-hash (table)
  (let ((data (nthcdr 2 (nbutlast
                         (split-string (pp-to-string table) "[()]")
                         2))))
    (insert (concat "(" (car data) ")"))))
