%% http://lsr.dsi.unimi.it/LSR/Item?id=331
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-fretted-strings
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/fretted-strings#fretted-strings-letter-tablature-formatting

music = \relative c {
  c4 d e f
  g4 a b c
  d4 e f g
}

<<
  \new Staff {
    \clef "G_8"
    \music
  }
  \new TabStaff \with {
    tablatureFormat = #fret-letter-tablature-format
  }
  {
    \music
  }
>>