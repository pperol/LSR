%% http://lsr.di.unimi.it/LSR/Item?id=524
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-reverting-default-beam-endings

\relative c'' {
  \time 12/8

  % Default beaming
  a8 a a a a a a a a a a a

  % Set new values for beam endings
  \set Score.beatStructure = #'(3 4 3 2)
  a8 a a a a a a a a a a a
}
