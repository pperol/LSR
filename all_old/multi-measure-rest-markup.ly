%% http://lsr.dsi.unimi.it/LSR/Item?id=587
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-rests#full-measure-rests

\relative c' {
  \compressFullBarRests
  \textLengthOn
  <>^\markup { [MAJOR GENERAL] }
  R1*19
  <>_\markup { \italic { Cue: ... it is yours } }
  <>^\markup { A }
  R1*30^\markup { [MABEL] }
  \textLengthOff
  c4^\markup { CHORUS } d f c
}
