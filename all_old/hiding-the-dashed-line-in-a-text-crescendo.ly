%% http://lsr.dsi.unimi.it/LSR/Item?id=404

\relative c'' {
  % Default: Dashed line
  \crescTextCresc 
  c4\< c c c\!
  \crescTextCresc 
  \once \override DynamicTextSpanner.style = #'none
  c4\< c c c\!
}
