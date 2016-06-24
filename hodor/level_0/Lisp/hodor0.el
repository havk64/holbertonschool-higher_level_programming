#!/usr/local/bin/emacs --script

;; ===----Hodor Level 0-------------------------------------------------------------------------===
;;      Voting from inside Emacs using `M-x ieml` or through *scratch*(Lisp Interaction) buffer.
;;      Lisp is awesome!!!
;;
;;      by Alexandro de Oliveira, for Holberton School.
;; ===------------------------------------------------------------------------------------------===

;; Using simple request in current Emacs buffer: (Just impressive 4 lines of code!)
(let ((url-request-method        "POST")
	(url-request-extra-headers `(("Content-Type" . "application/x-www-form-urlencoded")))
	(url-request-data          "id=23&holdthedoor=submit"))
    (with-current-buffer (url-retrieve-synchronously url) (buffer-string)))

;; Definition of some variables(following Lisp naming conventions:
(defconstant +url+ "http://173.246.108.142/level0.php" "Defining the url")	;; Global constant variable
(defvar *data* "id=23&holdthedoor=submit" "It accepts documentation!")		;; Global variable
(defvar *type* "application/x-www-form-urlencoded" "*type* variable created")	;; Global variable

 ;; Defining some functions with different options:

(defun vote()
  "A very simple function to vote. Content displayed in the same buffer."
  (let ((url-request-method        "POST")
	(url-request-extra-headers `(("Content-Type" . "application/x-www-form-urlencoded")))
	(url-request-data          *data*))
    (with-current-buffer (url-retrieve-synchronously +url+)
      (buffer-string))))

(defun vote-other-window()
  "Open new window(buffer) to show the results"
  (let ((url-request-method        "POST")
	(url-request-extra-headers `(("Content-Type" . "application/x-www-form-urlencoded")
				     ("User-Agent" ., (concat "Havk64 Emacs Lisp Http requests."))))
	(url-request-data          *data*))
    (url-retrieve +url+
		  (lambda (status)
		    "The callback as a anonymous function"
		    (progn (switch-to-buffer(current-buffer))
			   ;(rename-buffer "*Hold the Door*") ; Alternatively rename the buffer.
			   )))))
