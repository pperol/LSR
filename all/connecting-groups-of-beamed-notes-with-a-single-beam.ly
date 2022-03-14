\version "2.18.0"

\header {
  texidoc = "
Groups of beamed notes can be connected with a settable number of beams
using the @code{stemRightBeamCount} and @code{stemLeftBeamCount}
properties. 

"
  doctitle = "Connecting groups of beamed notes with a single beam"
}
%% http://lsr.di.unimi.it/LSR/Item?id=2
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms

\relative c'' {
  c32[ c c  
  \set stemRightBeamCount = #1
  c32
  \set stemLeftBeamCount = #1
  c32 c c c]
}

