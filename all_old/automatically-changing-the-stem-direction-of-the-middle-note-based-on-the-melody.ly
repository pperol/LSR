%% http://lsr.di.unimi.it/LSR/Item?id=751
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/pitches#pitches-automatically-changing-the-stem-direction-of-the-middle-note-based-on-the-melody


\relative c'' {
  \time 3/4
  a8 b g f b g |
  c b d c b c  |
}

\layout {
  \context {
    \Voice
    \consists "Melody_engraver"
    \autoBeamOff
    \stemNeutral
  }
}
