%% http://lsr.di.unimi.it/LSR/Item?id=601
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/volta_002dbracket_002dinterface
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/voltabracketspanner

\score {
  <<
    \chords {
      c1
      c1
    }
    \new Staff \with {
      \consists "Volta_engraver"
    }
    {
      \repeat volta 2 { c'1 }
      \alternative { c' }
    }
  >>
  \layout {
    \context {
      \Score
      \remove "Volta_engraver"
    }
  }
}
