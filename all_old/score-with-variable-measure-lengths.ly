%% http://lsr.di.unimi.it/LSR/Item?id=731
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms

%LSR odified by P.P.Schneider on Feb.2014

\new Staff \with { \omit TimeSignature } {
  \relative c'' {
    \time 3/4
    c4 c c
    \time 2/4
    c4 c
    \time 3/4
    c4 c c
    \time 2/4
    c4 c
    \time 5/4
    c4 c c c c
    \time 2/4
    c4 c
  }
}
