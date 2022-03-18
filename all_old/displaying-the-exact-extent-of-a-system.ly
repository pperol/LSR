%% http://lsr.di.unimi.it/LSR/Item?id=257
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/graphic


\layout { 
  \context {
    \Score
    \override System.stencil = #box-grob-stencil
  }
}

\new Voice {
  \unset Staff.minimumVerticalExtent
  \override Score.RehearsalMark.font-size = #20
  \slurDown c4 ( g4  c''4)
}
