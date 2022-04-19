#!/usr/bin/guile \
-e main -s
!#

(define (get-files stream)
  (let ((current (readdir stream)))
    (if (eof-object? current)
      '()
      (cons current (get-files stream)))))

(define (filter-hidden file-list)
  (cond ((null? file-list) '())
        ((string-prefix? "." (car file-list))
         (filter-hidden (cdr file-list)))
        (else (cons (car file-list) (filter-hidden (cdr file-list))))))

(define (sort-files file-list)
  (sort file-list string<?))

;; Display files, separated by space
(define (display-file file)
  (display file)
  (display " "))

;; Gets the target directory (which will be listed)
(define (get-dir args)
  (cond ((null? args) ".") ;; If no file argument found, default to '.'
        ((string-prefix? "-" (car args)) (get-dir (cdr args))) ;; If it's a flag, skip
        (else (car args)))) ;; Return the first non-flag argument

;; Gets the flags from the arguments (based on prefix)
(define (get-flags args)
  (cond ((null? args) '())
        ((or (string-prefix? "-" (car args))
             (string-prefix? "--" (car args)))
         (cons (car args) (get-flags (cdr args))))
        (else (get-flags (cdr args)))))

;; Long-list formatted output
(define (list-flag file-list)
  ;; TODO
  (map display-file file-list))

;; Called when the '-a' or '--all' flag is given
(define (all-flag file-list)
  (map display-file file-list))

;; Called when no flags are given
(define (no-flag file-list)
  (map display-file (filter-hidden file-list)))

(define (main args)
  (let ((file-list (sort-files (get-files (opendir (get-dir (cdr args))))))
        (flags (get-flags args)))
    (cond ((or (member "-a" flags)
               (member "--all" flags))
           (all-flag file-list))
          ((member "-l" flags)
           (list-flag file-list))
          (else (no-flag file-list)))))
