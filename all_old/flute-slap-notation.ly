%% http://lsr.dsi.unimi.it/LSR/Item?id=518
%% http://lilypond.org/doc/v2.18/Documentation/internals/notehead

slap =
#(define-music-function (parser location music) (ly:music?)
#{
  \override NoteHead.stencil =
  #(lambda (grob)
     (grob-interpret-markup grob
      (markup #:musicglyph "scripts.sforzato")))
  \override NoteHead.stem-attachment =
  #(lambda (grob)
     (let* ((thickness (ly:staff-symbol-line-thickness grob))
            (stem (ly:grob-object grob 'stem))
            (dir (ly:grob-property stem 'direction UP)))
       (cons 1 (+ (if (= dir DOWN)
                      0.5
                      0)
                  (/ thickness 2)))))
  $music
  \revert NoteHead.stencil
  \revert NoteHead.stem-attachment
#})

\relative c' {
  c4 \slap c d r
  \slap { g4 a } b r
}
