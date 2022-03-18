%% http://lsr.di.unimi.it/LSR/Item?id=707
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-adding-an-extra-staff-at-a-line-break


\markup { Example 1 }

\score {
  \new StaffGroup \relative c'' {
    c1 | c | c^"extra staff with staff beginning"
    <<
      {
        c1 | c | \break
        c1^"new system with brackets" | c
      }
      \new Staff {
        \once \override Staff.TimeSignature.transparent = ##t
        \once \override Staff.Clef.transparent = ##t
        e1 | e | e | e
      }
    >>
    c1 | c | c | c
  }
}

\markup { Example 2 }
\score {
  \new PianoStaff \relative c'' {
    c1 | c | c^"clean beginning of extra staff"
    <<
      {
        c1 | c | \break
        c1^"new system with braces" | c
      }
      \new Staff {
        \once \override Staff.TimeSignature.stencil = ##f
        \once \override Staff.Clef.stencil = ##f
        e1 e e e
      }
    >>
    c1 | c | c | c
  }
}
