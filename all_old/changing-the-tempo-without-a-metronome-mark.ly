%% http://lsr.di.unimi.it/LSR/Item?id=571
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/midi#midi-changing-the-tempo-without-a-metronome-mark

\score {
  \new Staff \relative c' {
    \tempo 4 = 160
    c4 e g b
    c4 b d c
    \set Score.tempoHideNote = ##t
    \tempo 4 = 96
    d,4 fis a cis
    d4 cis e d
  }
  \layout { }
  \midi { }
}
