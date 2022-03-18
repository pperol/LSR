%% http://lsr.di.unimi.it/LSR/Item?id=110
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-adding-an-extra-staff

\score {
  <<
    \new Staff \relative c'' {
      c1 | c | c | c | c
    }
    \new StaffGroup \relative c'' {
      \new Staff {
        c1 | c
        <<
          {
            c1 | d
          }
          \new Staff {
            \once \override Staff.TimeSignature.stencil = ##f
            c1 | b
          }
        >>
        c1
      }
    }
  >>
}

