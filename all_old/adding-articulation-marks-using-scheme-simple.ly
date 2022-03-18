%% http://lsr.di.unimi.it/LSR/Item?id=82
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks

#(define (make-script x)
   (make-music 'ArticulationEvent
               'articulation-type x))

#(define (add-script m x)
   (case (ly:music-property m 'name)
     ((NoteEvent) (set! (ly:music-property m 'articulations)
                      (append (ly:music-property m 'articulations)
                         (list (make-script x))))
                   m)
     ((EventChord)(set! (ly:music-property m 'elements)
                      (append (ly:music-property m 'elements)
                         (list (make-script x))))
                   m)
     (else #f)))

#(define (add-staccato m)
         (add-script m "staccato"))

addStacc = #(define-music-function (parser location music)
                 (ly:music?)
           (map-some-music add-staccato music))
           
%%% ............................................

\score {
   \relative c'' {
     c c c c
     \addStacc { c\p <c e> c-> c }
   }
} 
