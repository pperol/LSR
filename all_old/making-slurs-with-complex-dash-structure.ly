%% http://lsr.dsi.unimi.it/LSR/Item?id=816
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-making-slurs-with-complex-dash-structure

\relative c' {
  \once \override
    Slur.dash-definition = #'((0 0.3 0.1 0.75)
                                (0.3 0.6 1 1)
                                (0.65 1.0 0.4 0.75))
  c4( d e f)
  \once \override
    Slur.dash-definition = #'((0 0.25 1 1)
                                (0.3 0.7 0.4 0.75)
                                (0.75 1.0 1 1))
  c4( d e f)
}
