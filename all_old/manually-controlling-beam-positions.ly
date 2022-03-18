%% http://lsr.dsi.unimi.it/LSR/Item?id=97
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-manually-controlling-beam-positions

\relative c' {
  \time 2/4
  % from upper staff-line (position 2) to center (position 0)
  \override Beam.positions = #'(2 . 0)
  c8 c
  % from center to one above center (position 1)
  \override Beam.positions = #'(0 . 1)
  c8 c
}
