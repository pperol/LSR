%% http://lsr.di.unimi.it/LSR/Item?id=189
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music#vocal-music-chant-or-psalms-notation

stemOn = { \revert Staff.Stem.transparent }
stemOff = { \override Staff.Stem.transparent = ##t }

\score {
  \new Staff \with { \remove "Time_signature_engraver" }
  {
    \key g \minor
    \cadenzaOn
    \stemOff a'\breve bes'4 g'4
    \stemOn a'2 \bar "||"
    \stemOff a'\breve g'4 a'4
    \stemOn f'2 \bar "||"
    \stemOff a'\breve^\markup { \italic flexe }
    \stemOn g'2 \bar "||"
  }
}
