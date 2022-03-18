%% http://lsr.dsi.unimi.it/LSR/Item?id=286
%% see also : http://www.lilypond.org/doc/v2.18/Documentation/notation/typesetting-gregorian-chant

\include "gregorian.ly"

\score {
  \context VaticanaVoice {
    \override Script.padding = #-0.5
     {
      a\ictus
      a\circulus
      a\semicirculus
      a\accentus
      \[ a \episemInitium \pes b \flexa a \episemFinis \]
    }
  }
  \layout {
    line-width = 70.0
    width = 60.0
    indent = 0.0
    ragged-right = ##t
  }
}
