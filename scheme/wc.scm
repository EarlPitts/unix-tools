#!/usr/bin/guile \
-e main -s
!#

(use-modules (ice-9 textual-ports))

(define (make-counter bytes words lines)
  (list lines words bytes))

(define (lines counter)
  (car counter))

(define (words counter)
  (cadr counter))

(define (bytes counter)
  (caddr counter))

(define (add-byte counter)
  (make-counter
    (bytes counter)
    (words counter)
    (1+ (lines counter))))

(define (add-word counter)
  (make-counter
    (bytes counter)
    (1+ (words counter))
    (lines counter)))

(define (add-line counter)
  (make-counter
    (1+ (bytes counter))
    (words counter)
    (lines counter)))

(define (count text)
  (let loop ((remaining text)
             (counter (make-counter 0 0 0)))
    (cond ((null? remaining) counter)
          ((eq? (car remaining) #\newline) (loop (cdr remaining) (add-line counter)))
          ((eq? (car remaining) #\space) (loop (cdr remaining) (add-word counter)))
          (else (loop (cdr remaining) (add-byte counter))))))

(define (pretty-print counter)
  (display #\tab)
  (display (bytes counter))
  (display #\tab)
  (display (words counter))
  (display #\tab)
  (display (lines counter))
  (newline))

; TODO The numbers are way off for words and bytes
(define (main args)
  (pretty-print
    (count (string->list (get-string-all (current-input-port))))))
