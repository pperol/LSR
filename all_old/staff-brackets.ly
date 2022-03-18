%% http://lsr.di.unimi.it/LSR/Item?id=137
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/displaying-staves

myMusic = { c' d' e' f' }

\score { 
  <<
    \new StaffGroup << 
      \new Staff \myMusic
      \new StaffGroup <<
        \new Staff \myMusic
        \new GrandStaff <<
          \new Staff \myMusic
          \new Staff \myMusic
        >>
        \new Staff \myMusic
      >>
      \new ChoirStaff <<
        \new Staff \myMusic
        \new StaffGroup <<
          \new Staff \myMusic
        >>
        \new Staff \myMusic
      >>
    >>
    \new ChoirStaff << 
      \new Staff \myMusic
      \new ChoirStaff <<
        \new Staff \myMusic
        \new Staff \myMusic
      >>
      \new Staff \myMusic
    >>
  >>
  \layout { 
    raggedright = ##t 
  }
}
