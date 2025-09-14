(defun random-alnum ()
  (let* ((alnum "abcdefghijklmnopqrstuvwxyz0123456789")
         (i (% (abs (random)) (length alnum))))
    (substring alnum i (1+ i))))

(defun random-string (n)
  "Generate a slug of n random alphanumeric characters.

Inefficient implementation; don't use for large n."
  (if (= 0 n)
      ""
    (concat (random-alnum) (random-string (1- n)))))

(defun random-paragraph()
  (mapconcat
   (list 1 2 3 4 5)))


(defun random-md()
  (concat "# " (random-words 5) "\n"
          "tags= #" (random-string 8) "\n"
          (random-words 500) "\n")
  )

(defun xah-insert-random-number (NUM)
  "Insert NUM random digits.
NUM default to 5.
Call `universal-argument' before for different count.
URL `http://ergoemacs.org/emacs/elisp_insert_random_number_string.html'
Version 2017-05-24"
  (interactive "P")
  (let (($charset "1234567890" )
        ($baseCount 10))
    (dotimes (_ (if (numberp NUM) (abs NUM) 5 ))
      (insert (elt $charset (random $baseCount))))))


(defun xah-insert-random-string (NUM)
  "Insert a random alphanumerics string of length 5.
The possible chars are: A to Z, a to z, 0 to 9.
Call `universal-argument' before for different count.
URL `http://ergoemacs.org/emacs/elisp_insert_random_number_string.html'
Version 2018-08-03"
  (interactive "P")
  (let* (($charset "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
         ($baseCount (length $charset)))
    (dotimes (_ (if (numberp NUM) (abs NUM) 5))
      (insert (elt $charset (random $baseCount))))))

;; (log-to-file (random-md))
;; (let ((num 50000) (file-name ""))
;;   (while (> num 0)
;;     (setq file-name (concat "/tmp/test-files/" (random-string 25) ".md"))
;;     (f-append-text (random-md) nil file-name)
;;     (setq num (1- num))
;;     )
;;   )
(provide 'random)
