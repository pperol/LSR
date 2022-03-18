%% http://lsr.di.unimi.it/LSR/Item?id=324
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-changing-time-signatures-inside-a-polymetric-section-using-_005cscaledurations


\layout {
  \context {
    \Score
    \remove "Timing_translator"
    \remove "Default_bar_line_engraver"
  }
  \context {
    \Staff
    \consists "Timing_translator"
    \consists "Default_bar_line_engraver"
  }
}

<<
  \new Staff {
    \scaleDurations #'(8 . 5) {
      \time 6/8
      \set Timing.measureLength = #(ly:make-moment 6/5)
      b8 b b b b b
      \time 2/4
      \set Timing.measureLength = #(ly:make-moment 4/5)
      b4 b
    }
  }
  \new Staff {
    \clef bass
    \time 2/4
    c2 d e f
  }
>>
