%% http://lsr.dsi.unimi.it/LSR/Item?id=216
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/line-styles


\relative c'' {
  s2
  d2 \glissando d'2
  \once \override Glissando.style = #'dashed-line
  d,2 \glissando d'2
  \override Glissando.style = #'dotted-line
  d,2 \glissando d'2
  \override Glissando.style = #'zigzag
  d,2 \glissando d'2
  \override Glissando.style = #'trill
  d,2 \glissando d'2
}

