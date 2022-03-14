\version "2.18.0"

\header {
  texidoc = "
Time signatures may also be engraved in an old style.



"
  doctitle = "Ancient time signatures"
}
{
  \override Staff.TimeSignature.style = #'neomensural
  s1
}

