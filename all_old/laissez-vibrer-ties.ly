%% http://lsr.dsi.unimi.it/LSR/Item?id=211
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks#expressive-marks-laissez-vibrer-ties

\relative c' {
  <c e g>4\laissezVibrer r <c f g>\laissezVibrer r
  <c d f g>4\laissezVibrer r <c d f g>4.\laissezVibrer r8

  <c d e f>4\laissezVibrer r
  \override LaissezVibrerTieColumn.tie-configuration
     = #`((-7 . ,DOWN)
          (-5 . ,DOWN)
          (-3 . ,UP)
          (-1 . ,UP))
  <c d e f>4\laissezVibrer r
}
