%% http://lsr.di.unimi.it/LSR/Item?id=455
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-curves

\relative c'' {
  \override Score.SpacingSpanner.shortest-duration-space = #4.0
  c2-\bendAfter #5
  c2-\bendAfter #-4.75
  c2-\bendAfter #8.5
  c2-\bendAfter #-6
}
