%% http://lsr.dsi.unimi.it/LSR/Item?id=498
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/short-repeats

\relative c'' {
  \set countPercentRepeats = ##t
  \repeat percent 4 { c1 }
}
