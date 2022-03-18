%% http://lsr.di.unimi.it/LSR/Item?id=754
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/note-heads


%Association list of pitches to note head styles.
%Grouped by pitch. Defaults: 0 is C, 1 is D, ... 6 is B.
#(define style-mapping
   (list
    (cons (ly:make-pitch 0 6 SHARP) 'default)
    (cons (ly:make-pitch 0 0 NATURAL) 'default)
    (cons (ly:make-pitch 0 1 DOUBLE-FLAT) 'default)

    (cons (ly:make-pitch 0 6 DOUBLE-SHARP) 'la)
    (cons (ly:make-pitch 0 0 SHARP) 'la)
    (cons (ly:make-pitch 0 1 FLAT) 'la)

    (cons (ly:make-pitch 0 0 DOUBLE-SHARP) 'default)
    (cons (ly:make-pitch 0 1 NATURAL) 'default)
    (cons (ly:make-pitch 0 2 DOUBLE-FLAT) 'default)

    (cons (ly:make-pitch 0 1 SHARP) 'la)
    (cons (ly:make-pitch 0 2 FLAT) 'la)
    (cons (ly:make-pitch 0 3 DOUBLE-FLAT) 'la)

    (cons (ly:make-pitch 0 1 DOUBLE-SHARP) 'default)
    (cons (ly:make-pitch 0 2 NATURAL) 'default)
    (cons (ly:make-pitch 0 3 FLAT) 'default)

    (cons (ly:make-pitch 0 2 SHARP) 'default)
    (cons (ly:make-pitch 0 3 NATURAL) 'default)
    (cons (ly:make-pitch 0 4 DOUBLE-FLAT) 'default)

    (cons (ly:make-pitch 0 2 DOUBLE-SHARP) 'la)
    (cons (ly:make-pitch 0 3 SHARP) 'la)    
    (cons (ly:make-pitch 0 4 FLAT) 'la)

    (cons (ly:make-pitch 0 3 DOUBLE-SHARP) 'default)
    (cons (ly:make-pitch 0 4 NATURAL) 'default)
    (cons (ly:make-pitch 0 5 DOUBLE-FLAT) 'default)

    (cons (ly:make-pitch 0 4 SHARP) 'la)
    (cons (ly:make-pitch 0 5 FLAT) 'la)

    (cons (ly:make-pitch 0 4 DOUBLE-SHARP) 'default)
    (cons (ly:make-pitch 0 5 NATURAL) 'default)
    (cons (ly:make-pitch 0 6 DOUBLE-FLAT) 'default)

    (cons (ly:make-pitch 0 5 SHARP) 'la)
    (cons (ly:make-pitch 0 6 FLAT) 'la)
    (cons (ly:make-pitch 0 0 DOUBLE-FLAT) 'la)

    (cons (ly:make-pitch 0 5 DOUBLE-SHARP) 'default)
    (cons (ly:make-pitch 0 6 NATURAL) 'default)
    (cons (ly:make-pitch 0 0 FLAT) 'default)))


%Compare pitch and alteration (not octave).
#(define (pitch-equals? p1 p2)
   (and
    (= (ly:pitch-alteration p1) (ly:pitch-alteration p2))
    (= (ly:pitch-notename p1) (ly:pitch-notename p2))))

#(define (pitch-to-style pitch)
   (let ((style (assoc pitch style-mapping pitch-equals?)))
     (if style
         (cdr style))))

#(define (style-notehead grob)
   (pitch-to-style
    (ly:event-property (event-cause grob) 'pitch)))

\score {
  \new Staff \relative c' {
    \override NoteHead.style = #style-notehead
    c2 cis d dis e f fis g gis a ais b c
  }
}
