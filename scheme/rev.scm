#!/usr/bin/guile \
-e main -s
!#

(use-modules (ice-9 textual-ports))

(define (reverse l)
  (let iter ((remaining l)
             (new '()))
    (if (eq? remaining '())
      new
      (iter (cdr remaining)
            (cons (car remaining) new)))))

(define (reverse-string str)
  (list->string (reverse (string->list str))))

(define (rev-line line)
  (reverse-string line))

(define (main args)
  (let loop ((line (get-line (current-input-port))))
    (if (eof-object? line)
      (exit 0)
      (begin
        (display (reverse-string line))
        (newline)
        (loop (get-line (current-input-port)))))))
