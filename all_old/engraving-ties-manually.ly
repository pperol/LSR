%% http://lsr.dsi.unimi.it/LSR/Item?id=407
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-rhythms#ties


\relative c' {
  <c e g>2~ <c e g>
  \override TieColumn.tie-configuration =
    #'((0.0 . 1) (-2.0 . 1) (-4.0 . 1))
  <c e g>2~ <c e g>
}
