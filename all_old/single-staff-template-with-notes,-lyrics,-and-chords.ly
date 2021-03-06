%% http://lsr.di.unimi.it/LSR/Item?id=353
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/templates#templates-single-staff-template-with-notes-lyrics-and-chords

melody = \relative c' {
  \clef treble
  \key c \major
  \time 4/4

  a4 b c d
}

text = \lyricmode {
  Aaa Bee Cee Dee
}

harmonies = \chordmode {
  a2 c
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Voice = "one" { \autoBeamOff \melody }
    \new Lyrics \lyricsto "one" \text
  >>
  \layout { }
  \midi { }
}
