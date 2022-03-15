\version "2.22.0"
%% http://lsr.di.unimi.it/LSR/Item?id=2

\relative c'' {
  c32[ c c  
  \set stemRightBeamCount = #1
  c32
  \set stemLeftBeamCount = #1
  c32 c c c]
}