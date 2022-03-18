%% http://lsr.di.unimi.it/LSR/Item?id=450
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks#expressive-marks-vertically-aligning-dynamics-across-multiple-notes

\relative c' {
  \override DynamicLineSpanner.staff-padding = #4
  c2\p f\mf
  g2\< b4\> c\!
}
