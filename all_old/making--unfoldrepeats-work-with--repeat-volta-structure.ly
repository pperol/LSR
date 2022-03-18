%% http://lsr.dsi.unimi.it/LSR/Item?id=767


global = { s1 \repeat volta 2 { s1} \alternative {{s1} {s1} }} 
musicA = \relative c' { c1 d e f g}
musicB = \relative c' { \clef bass c,1 d e f g}

oldWayScore = \new StaffGroup  <<
    \new Staff <<\musicA \global>>
    \new Staff <<\musicB \global>>
  >>

\score { \oldWayScore }
\score { \unfoldRepeats \oldWayScore }
