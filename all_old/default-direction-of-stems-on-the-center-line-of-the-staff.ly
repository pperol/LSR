%% http://lsr.di.unimi.it/LSR/Item?id=422
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/stem


\relative c'' {
  a4 b c b
  \override Stem.neutral-direction = #up
  a4 b c b
  \override Stem.neutral-direction = #down
  a4 b c b
}
