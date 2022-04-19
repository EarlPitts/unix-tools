#!/usr/bin/guile \
-e main -s
!#

(use-modules (ice-9 textual-ports))

;; Returns the lines of the port as a list
(define (get-lines port)
  (let ((line (get-line port)))
    (if (eof-object? line)
      '()
      (cons line (get-lines port)))))

;; Display the elements of the passed list on stdout
(define (display-lines lines)
  (for-each 
    (lambda (x)
      (display x)
      (newline))
    lines))

;; Returns the lines that contain the string
(define (filter-lines lines s)
    (define (contains line)
      (string-contains line s))
    (filter contains lines))

;; TODO It should work with multiple files
(define (main args)
  (let ((search-term (cadr args))
        (filename (caddr args)))
    (display-lines
      (filter-lines
        (call-with-input-file filename get-lines)
        search-term))))
