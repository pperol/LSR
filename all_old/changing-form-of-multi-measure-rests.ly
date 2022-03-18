%%  http://lsr.di.unimi.it/LSR/Item?id=570
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-changing-form-of-multi_002dmeasure-rests


\relative c'' {
  \compressFullBarRests
  R1*2 | R1*5 | R1*9
  \override MultiMeasureRest.expand-limit = #3
  R1*2 | R1*5 | R1*9
}
