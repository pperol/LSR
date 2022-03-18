%% http://lsr.dsi.unimi.it/LSR/Item?id=797
%% modified for v2.18 by P.P.Schneider (Feb. 2014)

\relative c' {
  \once \override Beam.grow-direction = #RIGHT
  \once \override TupletBracket.bracket-visibility = ##t
  %% set note #UP or DOWN
  \once \override TupletNumber.text = \markup \note-by-number #2 #0 #UP  
  %% set TupletNumer Y alignment
  \once \override TupletNumber.Y-offset = #3.2
   \tuplet 1/1 {
    c32[ c c c c c c c c c c c]
  }
}
