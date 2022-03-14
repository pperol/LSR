\version "2.18.0"

\header {
  texidoc = "
Using @code{make-music}, you can add various stuff to notes. In this
example staccato dots are added to the notes.  For this simple case, it
is not necessary to use scm constructs.



"
  doctitle = "Adding articulation marks using Scheme (simple)"
}
%% http://lsr.di.unimi.it/LSR/Item?id=82
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks
%% see also https://github.com/lilypond/lilypond/blob/master/scm/music-functions.scm#L2036

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

