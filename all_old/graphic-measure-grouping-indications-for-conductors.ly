%% http://lsr.dsi.unimi.it/LSR/Item?id=259

\new Staff \with {
    \consists "Measure_grouping_engraver"
  }

\relative c' {
  \time #'(2 2) 2/4 
  c8 a'4 a8~
  \time #'(3 2) 5/8 
  a8 bes4 r8 bes8->
  \time #'(2 2) 2/4 
  c,8 g'4 g8~ 
  \time #'(3 2) 5/8 
  g8 a4 g a4.->
}
