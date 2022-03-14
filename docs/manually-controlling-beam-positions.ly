\version "2.18.0"

\header {
  texidoc = "
Beam positions may be controlled manually, by overriding the
@code{positions} setting of the @code{Beam} grob.




"
  doctitle = "Manually controlling beam positions"
}
\relative c' {
  \time 2/4
  % from upper staff-line (position 2) to center (position 0)
  \override Beam.positions = #'(2 . 0)
  c8 c
  % from center to one above center (position 1)
  \override Beam.positions = #'(0 . 1)
  c8 c
}

