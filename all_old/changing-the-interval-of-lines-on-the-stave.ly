%% http://lsr.di.unimi.it/LSR/Item?id=694
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/pitches#pitches-changing-the-interval-of-lines-on-the-stave


scale = \relative c' {
  a4 ais b c
  cis4 d dis e
  f4 fis g gis
  a1
}

\new Staff \with {
  \remove "Accidental_engraver"
  staffLineLayoutFunction = #ly:pitch-semitones
}
{
  <<
    \scale
    \context NoteNames {
      \set printOctaveNames = ##f
      \scale
    }
  >>
}
