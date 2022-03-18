%% http://lsr.dsi.unimi.it/LSR/Item?id=167

\score {
  \context Staff \relative c'' { c8 c c16 c c c }
  \layout{
    \context {
      \Staff
      \remove Staff_symbol_engraver
    }
  }
}
