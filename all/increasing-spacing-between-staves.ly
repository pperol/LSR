\paper {
  % spacing variables may be changed individually:
  system-system-spacing #'padding = #8
  % or as a group:
  %system-system-spacing =
    #'((basic-distance . 12)
       (minimum-distance . 8)
       (padding . 1)
       (stretchability . 60)) 
}

\score {
  \new Staff {
    \repeat unfold 96 { c''8[ c''] } 
  }
}

\layout {
   indent = 0\mm
}
