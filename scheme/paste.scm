#!/usr/bin/guile \
-e main -s
!#

(use-modules (ice-9 textual-ports))
(import (srfi srfi-1))

;; Returns the lines of the port as a list
(define (get-lines port)
  (let ((line (get-line port)))
    (if (eof-object? line)
      '()
      (cons line (get-lines port)))))

;; Display the elements of the passed list on stdout
(define (display-lines lines1 lines2)
  (for-each 
    (lambda (x y)
      (display x)
      (display #\tab)
      (display y)
      (newline))
    lines1 lines2))

;; TODO It should work with multiple files
(define (main args)
  (let ((first-file (cadr args))
        (second-file (caddr args)))
    (display-lines
      (call-with-input-file first-file get-lines)
      (call-with-input-file second-file get-lines))))
