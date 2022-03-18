%% http://lsr.dsi.unimi.it/LSR/Item?id=240
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/beam


\relative c'' {
  c32[ c
  \once \override Stem.beaming = #(cons (list 1 2) (list 0 2 4))
  c
  \once \override Stem.beaming = #(cons (list 0 2 4) (list 0 1 4))
  c c c]
}
