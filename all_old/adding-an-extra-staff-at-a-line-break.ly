%% http://lsr.di.unimi.it/LSR/Item?id=325
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-adding-an-extra-staff-at-a-line-break

\score {
  \new StaffGroup \relative c'' {
    \new Staff
    \key f \major
    c1 c^"Unwanted extra space" \break
    << { c1 | c }
       \new Staff {
         \key f \major
         \once \override Staff.TimeSignature.stencil = ##f
         c1 | c
       } 
    >>
    c1 | c^"Fixed here" \break
    << { c1 | c }
       \new Staff {
         \once \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
         \key f \major
         \once \override Staff.TimeSignature.stencil = ##f
         c1 | c
       }
    >>
  }
}
