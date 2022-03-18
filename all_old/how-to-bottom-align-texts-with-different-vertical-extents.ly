%% http://lsr.dsi.unimi.it/LSR/Item?id=652

\new Staff {
  \override TextScript.staff-padding = #4
  \override TextScript.self-alignment-X = #CENTER
  \textLengthOn
  \time 2/4
  c'4_\markup { \combine \transparent f WRONG }
  c'4_\markup { case }
  c'4_\markup { \combine \transparent f RIGHT }
  c'4_\markup { \combine \transparent f case }
}
