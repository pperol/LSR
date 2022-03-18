%% http://lsr.dsi.unimi.it/LSR/Item?id=290

rh = \relative c' {
  b''8-3(\f g-1) d'2-5(\sf c16 b a g)
#(define afterGraceFraction (cons 31 32))
 \acciaccatura b8-3 \slurDown \afterGrace a1  \startTrillSpan \( ( {g16[ a ] )
\stopTrillSpan}
  g4 \) r2.
}

lh = \relative c' {
  \clef treble 
  d16_5 b'_1 g_2 b \repeat unfold 3 { d, b' g b } 
  \repeat unfold 4 { d, c' fis, c' }
  <g-2 b-1>4 r2. 
}

\score {
  \new PianoStaff <<
    \new Staff \rh
    \new Staff \lh
  >>
}
