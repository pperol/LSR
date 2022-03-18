%% http://lsr.di.unimi.it/LSR/Item?id=639
%% see also http://lsr.di.unimi.it/LSR/Item?id=777
%% see also %% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-curves

% LSR Thanks to Neil Puttock for his help!

shapeSlur =
  #(define-music-function (parser location offsets) (list?)
    #{
       \once \override Slur.control-points = #(alter-curve offsets)
    #})

#(define ((alter-curve offsets) grob)
   (let ((coords (ly:slur::calc-control-points grob)))

     (define (add-offsets coords offsets)
       (if (null? coords)
       '()
       (cons
	 (cons (+ (caar coords) (car offsets))
	       (+ (cdar coords) (cadr offsets)))
	 (add-offsets (cdr coords) (cddr offsets)))))

     (add-offsets coords offsets)))

\relative c'' {
  d4(^"default" d' b g f8 e d e c2)
  \bar "||"
  \shapeSlur #'(0 -2.5 -1 3.5 0 0 0 -2.5)
  d4(^"(0 -2.5 -1 3.5 0 0 0 -2.5)" d' b g f8 e d e c2)
}
