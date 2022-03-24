\score {
  \new Staff \relative c'' {
    a4 b c d
    d4 c b a
  }
  \layout {
    \context {
      \Staff
      \omit TimeSignature
      \omit BarLine
    }
  }
}
