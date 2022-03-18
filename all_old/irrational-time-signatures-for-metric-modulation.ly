%% http://lsr.dsi.unimi.it/LSR/Item?id=552

metrmods = \relative c' {
  \time 4/4
  \tempo 4 = 60
  fis4 fis fis fis
  \time 2/6
  g4*2/3 g |
  g4*2/3 g |
  \time 4/5
  as4*4/5 as as as8*4/5 g |
  \tuplet 3/2 { as4*4/5 as as } as4*4/5 as8*4/5 g |
  \time 3/7
  fis4*4/7 fis fis |
  fis4*4/7 fis fis |
}

\score {
  \metrmods
  % uncomment to check MIDI output.
  % \midi { }
  \layout { }
}
