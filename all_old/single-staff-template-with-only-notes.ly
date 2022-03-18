%% http://lsr.di.unimi.it/LSR/Item?id=350
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/templates#templates-single-staff-template-with-only-notes

melody = \relative c' {
  \clef treble
  \key c \major
  \time 4/4

  a4 b c d
}

\score {
  \new Staff \melody
  \layout { }
  \midi { }
}
