%% http://lsr.di.unimi.it/LSR/Item?id=339
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks

\relative c' {
  \override Hairpin.style = #'trill
  c2\< c\!\mf
  \override Hairpin.style = #'zigzag
  c2\< c\!\mf
}
