%% http://lsr.di.unimi.it/LSR/Item?id=284
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/rotating-objects

\relative c' {
  \textLengthOn
  c4^\markup { \rotate #45.0 hello }
  c4^\markup { \rotate #90.0 hello }
  r4
  c4^\markup { \column { h e l l o } }
}
