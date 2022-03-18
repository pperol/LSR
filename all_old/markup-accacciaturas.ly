%% http://lsr.dsi.unimi.it/LSR/Item?id=458

%LSR This solution was originally provided by the German LilyPond Forum.

\transpose c c'' {
 \key g \major
 \time 2/4
 \tupletSpan 8
 \override Script.padding = #1

  \appoggiatura f16
    _\markup { 
      [ \note #"8" #1
      \translate #(cons -1.5 2.9) { \musicglyph #"flags.ugrace" } ] 
    }
  e8 d r b |

  \appoggiatura f16
    _\markup { 
      [ \fontsize #-6 \note #"8" #1
      \translate #(cons -1.05 1.5) { 
        \fontsize #-6 \musicglyph #"flags.ugrace" 
      }
      \normalsize ] 
    }
  e8 d r b |
}
