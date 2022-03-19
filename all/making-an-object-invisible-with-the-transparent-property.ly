\relative c'' {
  \time 2/4
  <<
    {
      \once \override Stem.transparent = ##t
      \once \override Stem.length = #8
      b8 ~ b\noBeam
      \once \override Stem.transparent = ##t
      \once \override Stem.length = #8
      g8 ~ g\noBeam
    }
    \\
    {
      b8 g g e
    }
  >>
}
