%% http://lsr.di.unimi.it/LSR/Item?id=525
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/beams

\relative c'' {
  \time 7/8
  % rhythm 2-3-2
  a8 a a a a a a
  \set Score.beatStructure = #'(2 3 2)
  a8 a a a a a a
}
