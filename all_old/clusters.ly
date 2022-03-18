%% http://lsr.di.unimi.it/LSR/Item?id=212
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/single-voice.html#clusters

fragment = \relative c' {
  c4 f <e d'>4
  <g a>8 <e a> a4 c2 <d b>4
  e2 c
}

<<
  \new Staff \fragment
  \new Staff \makeClusters \fragment
>>
