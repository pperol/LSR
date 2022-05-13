\relative {
  \time 2/4
  <<
    {
      \once \hide Stem
      \once \override Stem.length = #8
      b'8 ~ 8\noBeam
      \once \hide Stem
      \once \override Stem.length = #8
      g8 ~ 8\noBeam
    }
    \\
    {
      b8 g g e
    }
  >>
}
