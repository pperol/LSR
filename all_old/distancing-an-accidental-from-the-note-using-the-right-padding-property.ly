%% http://lsr.di.unimi.it/LSR/Item?id=4
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/accidental


\relative c'' {
  \time 1/4
  \once \override Staff.AccidentalPlacement.right-padding = #.5 cis
  \once \override Staff.AccidentalPlacement.right-padding = #1 cis
  \once \override Staff.AccidentalPlacement.right-padding = #1.5 cis
  \once \override Staff.AccidentalPlacement.right-padding = #2 cis
}
