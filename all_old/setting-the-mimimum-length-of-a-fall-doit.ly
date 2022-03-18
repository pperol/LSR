%% http://lsr.di.unimi.it/LSR/Item?id=565
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-curves#falls-and-doits

noteFix = {
  \once \override BendAfter.springs-and-rods = #ly:spanner::set-spacing-rods
  \once \override BendAfter.minimum-length = #5
}

\relative c' {
  f2.~ f8
  \noteFix
  f-\bendAfter #-4 |
  r2 r8 c d f |
}
