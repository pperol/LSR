%% http://lsr.di.unimi.it/LSR/Item?id=489
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/outside-the-staff

\layout {
  \context {
    \Voice
    \consists "Horizontal_bracket_engraver"
  }
}

\relative c'' {
  \once \override HorizontalBracket.direction = #UP
  c2\startGroup
  d2\stopGroup
}
