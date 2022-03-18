%% http://lsr.di.unimi.it/LSR/Item?id=352
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/templates#templates-single-staff-template-with-notes-and-chords


melody = \relative c' {
  \clef treble
  \key c \major
  \time 4/4

  f4 e8[ c] d4 g
  a2 ~ a
}

harmonies = \chordmode {
  c4:m f:min7 g:maj c:aug
  d2:dim b:sus
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff \melody
  >>
  \layout{ }
  \midi { }
}
