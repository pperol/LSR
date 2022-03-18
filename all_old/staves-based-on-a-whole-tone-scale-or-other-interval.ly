%% http://lsr.di.unimi.it/LSR/Item?id=755
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/nullvoice

%LSR: Graham Breed gets the credit for this solution

scale = \relative c' {
  c4 d e fis 
  gis4 ais c2
  f,4 g a b 
  cis4 dis f2
  c,4 cis d dis 
  e4 f fis g
  gis4 a ais b
  c1
}

\new Staff \with {
  \remove "Accidental_engraver"
  staffLineLayoutFunction = #(lambda (p) (floor (/ (ly:pitch-semitones p) 2)))
}
{
  <<
    \scale
    \new NoteNames {
      \set printOctaveNames = ##f
      \scale
    }
  >>
}
