%% http://lsr.di.unimi.it/LSR/Item?id=756
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks#expressive-marks-creating-double_002ddigit-fingerings


ten =
#(make-music 'FingeringEvent
             'digit 10)

fifty =
#(make-music 'FingeringEvent
             'digit 50)

finger =
#(define-music-function (parser location digit) (integer?)
   (make-music 'FingeringEvent
               'digit digit))

#(define (calc-finger-without-warning grob)
   (let* ((event (event-cause grob))
	  (digit (ly:event-property event 'digit)))
     (number->string digit 10)))

\relative c' {
  % optional override to remove warnings for fingerings larger than 5
  \override Fingering.text = #calc-finger-without-warning
  c1\ten
  c1\fifty
  c1-\finger #36
  c1-\finger #29
}
