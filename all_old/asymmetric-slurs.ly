%% http://lsr.di.unimi.it/LSR/Item?id=683
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-curves


slurNotes = { d,8( a' d f a f' d, a) }

\relative c' {
  \stemDown
  \slurUp
  \slurNotes
  \once \override Slur.eccentricity = #3.0
  \slurNotes
}
