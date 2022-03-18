%% http://lsr.di.unimi.it/LSR/Item?id=800
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-changing-the-number-of-augmentation-dots-per-note


\relative c' {
  c4.. a16 r2 |
  \override Dots.dot-count = #4
  c4.. a16 r2 |
  \override Dots.dot-count = #0
  c4.. a16 r2 |
  \revert Dots.dot-count
  c4.. a16 r2 |
}
