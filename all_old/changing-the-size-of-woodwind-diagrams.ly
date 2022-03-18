%% http://lsr.di.unimi.it/LSR/Item?id=801
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/woodwind-diagrams


\relative c'' {
  \textLengthOn
  c1^\markup
    \woodwind-diagram
      #'piccolo
      #'()

  c^\markup
    \override #'(size . 1.5) {
      \woodwind-diagram
        #'piccolo
        #'()
    }
  c^\markup
    \override #'(thickness . 0.15) {
      \woodwind-diagram
        #'piccolo
        #'()
    }
}
