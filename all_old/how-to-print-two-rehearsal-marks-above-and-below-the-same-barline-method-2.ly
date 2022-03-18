%% http://lsr.dsi.unimi.it/LSR/Item?id=736

\score {
  \relative c'
  <<
    \new Staff {
      <<
        \new Voice \with {
          \consists Mark_engraver
          \consists "Staff_collecting_engraver"
        }
        { c4 d e f 
          \mark \markup { \box A } 
          c4 d e f 
        }
        \new Voice \with {
          \consists Mark_engraver
          \consists "Staff_collecting_engraver"
          \override RehearsalMark.direction = #DOWN
        }
        { s4 s s s
          \mark \markup { \circle 1 } 
          s4 s s s 
        }
      >>
    }
  >>
  \layout {
    \context {
      \Score
      \remove "Mark_engraver"
      \remove "Staff_collecting_engraver"
    }
  }
}
