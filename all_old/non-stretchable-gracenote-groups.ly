%% http://lsr.dsi.unimi.it/LSR/Item?id=740
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/special-rhythmic-concerns

\relative c' {
  c4 c_"Normally" \grace { g'32[ c, g' c, g'] } c,4 c |
  c4 c c c | \break
  c4 c_"With tweak applied"
  \override Score.GraceSpacing.spacing-increment = #0
  \grace { g'32[ c, g' c, g'] } c,4 c |
  c4 c c c
}
