%% http://lsr.di.unimi.it/LSR/Item?id=835
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-compound-time-signatures

\relative c' {
  \compoundMeter #'((2 8) (3 8))
  c8 d e fis gis
  c8 fis, gis e d
  c8 d e4 gis8
}
