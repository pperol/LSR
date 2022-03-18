%% http://lsr.di.unimi.it/LSR/Item?id=220
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats#repeats-volta-multi-staff

voltaMusic = \relative c'' {
  \repeat volta 2 {
    c1
  }
  \alternative {
    d1
    e1
  }
}

<<
  \new StaffGroup <<
    \new Staff \voltaMusic
    \new Staff \voltaMusic
  >>
  \new StaffGroup <<
    \new Staff \with { \consists "Volta_engraver" }
      \voltaMusic
    \new Staff \voltaMusic
  >>
>>
