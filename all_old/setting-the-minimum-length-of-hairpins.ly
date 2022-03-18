%% http://lsr.di.unimi.it/LSR/Item?id=448
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-attached-to-notes

\relative c'' {
  c4\< c\! d\> e\!
  \override Hairpin.minimum-length = #5
  << f1 { s4 s\< s\> s\! } >>
}
