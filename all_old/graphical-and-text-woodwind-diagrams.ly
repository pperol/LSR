%% http://lsr.dsi.unimi.it/LSR/Item?id=812
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/woodwind-diagrams

\relative c'' {
  \textLengthOn
  c1^\markup
    \woodwind-diagram
      #'piccolo
      #'((cc . (one three))
         (lh . (gis))
         (rh . (ees)))

  c^\markup
    \override #'(graphical . #f) {
      \woodwind-diagram
        #'piccolo
        #'((cc . (one three))
           (lh . (gis))
           (rh . (ees)))
    }
}
