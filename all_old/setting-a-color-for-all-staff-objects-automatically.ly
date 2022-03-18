%% http://lsr.di.unimi.it/LSR/Item?id=443
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/visibility-and-color-of-objects

#(define (override-color-for-all-grobs color)
  (lambda (context)
   (let loop ((x all-grob-descriptions))
    (if (not (null? x))
     (let ((grob-name (caar x)))
      (ly:context-pushpop-property context grob-name 'color color)
      (loop (cdr x)))))))

\relative c' {
  \applyContext #(override-color-for-all-grobs (x11-color 'blue))
  c4\pp\< d e f
  \grace { g16[( a g fis]) } g1\ff\!
}
