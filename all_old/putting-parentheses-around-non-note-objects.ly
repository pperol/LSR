%% http://lsr.di.unimi.it/LSR/Item?id=421
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks

\relative c' {
  < c d g >2-\parenthesize -. 
  \once \override ParenthesesItem.font-size = #0
  c-\parenthesize \trill
}
