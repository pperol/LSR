%% http://lsr.di.unimi.it/LSR/Item?id=449
%% http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-attached-to-notes

\relative c'' {
  \override Hairpin.circled-tip = ##t
  c2\< c\!
  c4\> c\< c2\!
}
