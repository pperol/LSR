%% http://lsr.di.unimi.it/LSR/Item?id=442
%% see also http://www.lilypond.org/doc/v2.18/Documentation/learning/within_002dstaff-objects

\score {
  \new Staff << 
  \new Voice \relative c' {
    \time 2/4
    <c d g b d>2
  }
  \new Voice \relative c' {
    \hideNotes
    \arpeggioBracket
    \once \override NoteColumn.ignore-collision = ##t
    <c d>2\arpeggio
  }
  >>
  \layout { ragged-right = ##t }
}
