%% http://lsr.di.unimi.it/LSR/Item?id=725
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms


#(define ((double-time-signature glyph a b) grob)
   (grob-interpret-markup grob
          (markup #:override '(baseline-skip . 2.5) #:number
                  (#:line ((markup (#:fontsize 4 #:musicglyph glyph))
                           (#:fontsize -1 #:column (a b)))))))

music = \relative c' {
  \override Score.TimeSignature.stencil =
      #(double-time-signature  "timesig.mensural64" "3" "2")
  \time 3/4
  c8 b c d e f g4 g g g4 a8 g f e d2. \bar "|."
}

\score { \music }
