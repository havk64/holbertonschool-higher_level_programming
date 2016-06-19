#!/usr/local/bin/emacs --script

;; ===----Hodor Level 0-------------------------------------------------------------------------===
;;      Voting from inside Emacs using `M-x ieml` or through *scratch*(Lisp Interaction) buffer.
;;      Lisp is awesome!
;;
;;      by Alexandro de Oliveira, for Holberton School.
;; ===------------------------------------------------------------------------------------------===
(let ((url-request-method        "POST")
      (url-request-extra-headers `(("Content-Type" . "application/x-www-form-urlencoded")))
      (url-request-data          "id=23&holdthedoor=submit"))
  (with-current-buffer (url-retrieve-synchronously "http://173.246.108.142/level0.php")
                (buffer-string)))
