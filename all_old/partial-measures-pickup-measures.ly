%% http://lsr.dsi.unimi.it/LSR/Item?id=183
%% see also http://www.lilypond.org/doc/v2.17/Documentation/learning/advanced-rhythmic-commands#partial-measure

\relative c''{
  \partial 16*5 c16 cis d dis e | a2. c,4 | b1
}

% Below are the instruction to set the pickup bar with the grace note.
\relative c'' {
  \grace f16
  \partial 4
  g4
  a2 g2
}
