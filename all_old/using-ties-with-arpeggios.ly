%% http://lsr.di.unimi.it/LSR/Item?id=408
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-using-ties-with-arpeggios

\relative c' {
  \set tieWaitForNote = ##t
  \grace { c16[ ~ e ~ g] ~ } <c, e g>2
  \repeat tremolo 8 { c32 ~ c' ~ } <c c,>1
  e8 ~ c ~ a ~ f ~ <e' c a f>2
  \tieUp
  c8 ~ a
  \tieDown
  \tieDotted
  g8 ~ c g2
}
