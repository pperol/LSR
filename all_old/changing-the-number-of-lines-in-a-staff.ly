%% http://lsr.di.unimi.it/LSR/Item?id=139
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-changing-the-number-of-lines-in-a-staff


upper = \relative c'' {
  c4 d e f
}

lower = \relative c {
  \clef bass
  c4 b a g
}

\score {
  \context PianoStaff <<
    \new Staff {
      \upper
    }
    \new Staff {
      \override Staff.StaffSymbol.line-count = #4 
      \lower
    }
  >>
}
