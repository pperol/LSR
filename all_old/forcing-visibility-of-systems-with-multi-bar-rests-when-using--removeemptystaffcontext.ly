%% http://lsr.dsi.unimi.it/LSR/Item?id=312

showMultiRests = {
 \set Staff.keepAliveInterfaces = #'(
    rhythmic-grob-interface
    multi-measure-rest-interface
    lyric-interface
    stanza-number-interface
    percent-repeat-interface)
}
hideMultiRests = \unset Staff.keepAliveInterfaces
one = {
 \repeat unfold 4 { a1 b c' d' \break }
 % Macro positioning is critical - overrides are inside each system
 %i.e. after first rest and before last
 R1 \showMultiRests R R \hideMultiRests R \break
 R1*4 \break
 R
}
two = {
 \override MultiMeasureRest.color = #red
 R1*4
 R1 \showMultiRests R R \hideMultiRests R
 R1*4
 R
 R1 \showMultiRests R R R
 R R R \hideMultiRests R
 R1*4
}
three = {
 \override MultiMeasureRest.color = #blue
 R1*4
 R
 R1 \showMultiRests R R \hideMultiRests R
 R1*4
 R1 \showMultiRests R R \hideMultiRests R
 R1*4
 R1 \showMultiRests R R R
}
\score {
 \new StaffGroup { <<
  \context Staff = one \one
  \context Staff = two \two
  \context Staff = three \three
  >>
 }
 \layout {
  \context { \Staff \RemoveEmptyStaves }
 }
}
