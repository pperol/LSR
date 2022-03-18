%% http://lsr.di.unimi.it/LSR/Item?id=592
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-printing-the-bar-number-for-the-first-measure

\layout {
  indent = 0
  ragged-right = ##t
}

\relative c' {
  \set Score.barNumberVisibility = #all-bar-numbers-visible
  \bar ""
  c1 | d | e | f \break
  g1 | e | d | c
}
