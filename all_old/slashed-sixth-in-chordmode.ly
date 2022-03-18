%% http://lsr.di.unimi.it/LSR/Item?id=549
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/displaying-chords

myChordDefinitions = {
  <es g ais c>-\markup \super {
    \combine
    6
    \raise #0.3 \rotate #-75 \bold /
  }
}

myChordExceptions = #(append
  (sequential-music-to-chord-exceptions myChordDefinitions #t)
  ignatzekExceptions)

myChordInit = {
  \set chordNameExceptions = #myChordExceptions
}

music = \relative c' {
  c2 f
}

chord = \chords {
  \myChordInit
  c2 f:m6+
}

\score {
  <<
    \chord
    \new Staff \music
  >>
}
