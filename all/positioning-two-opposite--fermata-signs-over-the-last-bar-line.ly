\score {
  \new GrandStaff <<
    \context Staff = one {
      c'1 \bar "|."
      \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
      \mark \markup { \musicglyph #"scripts.ufermata" }
    }
    \context Staff = two \with { \consists "Mark_engraver" } {
      c'1
      \override Staff.RehearsalMark.direction = #DOWN
      \mark \markup { \musicglyph #"scripts.dfermata" }
    }
  >>
}
