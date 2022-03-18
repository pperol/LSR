%%http://lsr.dsi.unimi.it/LSR/Item?id=859


#(define rng (seed->random-state 1337))

#(define (make-circle-path r dev)
   (let ((k (* r 0.5522847498))
         (o (lambda () (* r dev (random:normal rng)))))
     (list
       (list 'moveto 0 r)
       (list 'curveto k r r k r (o))
       (list 'curveto r (- k) k (- r) (o) (- r))
       (list 'curveto (- k) (- r) (- r) (- k) (- r) (o))
       (list 'curveto (- r) k (- k) r 0 r))))

\new Staff \relative c' {
  \override NoteHead.stencil =
    #(lambda (grob)
       (let ((fill (> (ly:grob-property grob 'duration-log) 1)))
         (grob-interpret-markup grob
           (markup #:rotate 45
                   #:scale '(1.3 . 0.7)
                   #:override `(filled . ,fill)
                   #:path 0.25 (make-circle-path 0.5 0.2)))))
  \override NoteHead.stem-attachment = #'(0.8 . 0.1)
  | c8 d8 e8 f8 g2
  \revert NoteHead.stencil
  \revert NoteHead.stem-attachment
  | c,8 d8 e8 f8 g2
}
