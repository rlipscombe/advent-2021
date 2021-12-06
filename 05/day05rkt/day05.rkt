#lang racket

(define (parse-line str)
  (match str [(regexp #rx"^([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)$" (list _ x1 y1 x2 y2))
              (list (list (string->number x1)
                          (string->number y1))
                    (list (string->number x2)
                          (string->number y2)))]))

(define segments (map parse-line
                      (file->lines "example")))

(println segments)

(define (is-orthogonal? _)
  #t)

(filter is-orthogonal? segments)
