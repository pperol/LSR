%% http://lsr.di.unimi.it/LSR/Item?id=2
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms

\relative c'' {
  c32[ c c  
  \set stemRightBeamCount = #1
  c32
  \set stemLeftBeamCount = #1
  c32 c c c]
}
