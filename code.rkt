#lang racket

;; Mode detection
(define args (current-command-line-arguments))
(define interactive?
  (or (zero? (vector-length args))
      (not (member (vector-ref args 0) (list "-b" "--batch")))))

;; Tokenize input string
(define (tokenize str)
  (filter (lambda (s) (not (string=? s "")))
          (regexp-split #px"\\s+" str)))

;; Evaluate user input and return either value or error message
(define (eval-tokens tokens history)
  (define-values (result remaining) (eval-expr tokens history))
  (cond
    [(string? result) result]
    [(null? remaining) result]
    [else "Invalid Expression"]))

;; Expression parser
(define (eval-expr tokens history)
  (if (null? tokens)
      (values "Invalid Expression" '())
      (let ([t (car tokens)]
            [rest (cdr tokens)])
        (cond
          [(equal? t "+")
           (define-values (a r1) (eval-expr rest history))
           (define-values (b r2) (eval-expr r1 history))
           (if (or (string? a) (string? b))
               (values "Invalid Expression" '())
               (values (+ a b) r2))]
          [(equal? t "*")
           (define-values (a r1) (eval-expr rest history))
           (define-values (b r2) (eval-expr r1 history))
           (if (or (string? a) (string? b))
               (values "Invalid Expression" '())
               (values (* a b) r2))]
          [(equal? t "/")
           (define-values (a r1) (eval-expr rest history))
           (define-values (b r2) (eval-expr r1 history))
           (cond
             [(or (string? a) (string? b)) (values "Invalid Expression" '())]
             [(zero? b) (values "Invalid Expression" '())]
             [else (values (quotient a b) r2)])]
          [(equal? t "-")
           (define-values (a r1) (eval-expr rest history))
           (if (string? a)
               (values "Invalid Expression" '())
               (values (- a) r1))]
          [(regexp-match #px"^\\$\\d+$" t)
           (define id (string->number (substring t 1)))
           (if (or (not id) (< id 1) (> id (length history)))
               (values "Invalid Expression" '())
               (values (list-ref (reverse history) (- id 1)) rest))]
          [(string->number t)
           => (lambda (n) (values n rest))]
          [else (values "Invalid Expression" '())]))))

;; Main loop
(define (main-loop history)
  (when interactive? (display "Enter expression: "))
  (define input (read-line))
  (cond
    [(eof-object? input) (void)]
    [(string=? input "quit") (void)]
    [else
     (define tokens (tokenize input))
     (define result (eval-tokens tokens history))
     (cond
       [(string? result)
        (displayln (string-append "Error: " result))
        (main-loop history)]
       [else
        (define new-history (cons result history))
        (define index (length new-history))
        (display index)
        (display ": ")
        (display (real->double-flonum result))
        (newline)
        (main-loop new-history)])]))

;; Start
(main-loop '())
