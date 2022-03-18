%% http://lsr.di.unimi.it/LSR/Item?id=476
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-chords

harmonies = \chordmode {
  c1:m c:m \break c:m c:m d
}

<<
  \new ChordNames {
    \set chordChanges = ##t
    \harmonies
  }
  \new Staff {
    \relative c' { \harmonies }
  }
>>
