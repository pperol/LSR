\relative c' {
  \set beamExceptions = #'()
  \set baseMoment = #(ly:make-moment 4/32)
  f32 g a b b a g f

  f32 g a
  \set stemRightBeamCount = #1 b
  \set stemLeftBeamCount = #1 b
  a g f
}
