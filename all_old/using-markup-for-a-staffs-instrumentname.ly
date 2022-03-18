%% http://lsr.di.unimi.it/LSR/Item?id=515
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/graphic

\new Staff = "Percussion" <<
  %Use a markup as the instrumentName for the staff!
  \set Staff.instrumentName = \markup {
    \combine
      \translate #(cons -1.25 0) \combine
        \draw-circle #0.65 #0 ##t
        \override #'(thickness . 2.5) \draw-line #'(3 . -3)
      \translate #(cons 1.25 0) \combine
        \draw-circle #0.65 #0 ##t
        \override #'(thickness . 2.5) \draw-line #'(-3 . -3)
  }
  \new Voice \relative c' { c1 }
>>
