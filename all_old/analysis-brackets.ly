%% http://lsr.di.unimi.it/LSR/Item?id=426
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/outside-the-staff


\layout {
  \context {
    \Voice
    \consists "Horizontal_bracket_engraver"
  }
}
\relative c'' {
  c4\startGroup\startGroup
  d4\stopGroup
  e4\startGroup
  d4\stopGroup\stopGroup
}
