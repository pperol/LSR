%% http://lsr.di.unimi.it/LSR/Item?id=427
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats#repeats-adding-volta-brackets-to-additional-staves

<<
  \new Staff { \repeat volta 2 { c'1 } \alternative { c' } }
  \new Staff { \repeat volta 2 { c'1 } \alternative { c' } }
  \new Staff \with { \consists "Volta_engraver" } { c'2 g' e' a' }
  \new Staff { \repeat volta 2 { c'1 } \alternative { c' } }
>>
