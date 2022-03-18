%% http://lsr.dsi.unimi.it/LSR/Item?id=7
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/moving-objects

\relative c' {
  \stemUp
  f-5
  \once \override Fingering.extra-offset = #'(-0.3 . -1.8) 
  f-5

}

