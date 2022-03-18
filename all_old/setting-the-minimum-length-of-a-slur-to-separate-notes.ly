%% http://lsr.di.unimi.it/LSR/Item?id=135
%% see also http://www.lilypond.org/doc/v2.18/Documentation/learning/length-and-thickness-of-objects
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/slur

\score{
  \relative c''{
    \time 2/4
    \override Slur.minimum-length = #40
    c( c)
    c~ c\break
  }
}
