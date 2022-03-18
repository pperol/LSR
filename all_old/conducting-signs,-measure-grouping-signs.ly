%% http://lsr.di.unimi.it/LSR/Item?id=523
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-conducting-signs-measure-grouping-signs

\score {
  \new Voice \relative c'' {
    \time 9/8
    g8 g d d g g a( bes g) |
    \set Timing.beatStructure = #'(2 2 2 3)
    g8 g d d g g a( bes g) |
    \time #'(4 5) 9/8
    g8 g d d g g a( bes g) |
    \time 5/8
    a4. g4 |
  }
  \layout {
    \context {
      \Staff
      \consists "Measure_grouping_engraver"
    }
  }
}
