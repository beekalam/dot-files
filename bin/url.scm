#! /usr/bin/guile \
-e main -s
!#
(use-modules (ice-9 string-fun))
(define (main args)
  (define url (list-ref args 2))
  (display (uri-components url))
  (newline))



(define (url-query url)
  (cadr (string-split url #\?)))


(define (uri-components url)
  (let* ([query (url-query url)]
        [parts (string-split query #\&)]
        [lines (string-replace-substring query "&" "\n")])
    ;; (display query)
    ;; (newline)
    ;; (display parts)
    ;; (newline)
    ;; (display lines)
    ;; (newline)
    lines))
