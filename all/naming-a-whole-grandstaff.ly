\score {
  \new GrandStaff <<
    \new Staff = "treble" {
      \set GrandStaff.instrumentName = "Violini  "
      \set Staff.instrumentName = " vn I" { c''4 }
    }
    \new Staff = "bass" { \set Staff.instrumentName = " vn II" c''4 }
  >>
}
