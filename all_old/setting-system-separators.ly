%% http://lsr.di.unimi.it/LSR/Item?id=687
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-setting-system-separators

\paper {
  system-separator-markup = \slashSeparator
}

notes = \relative c' {
  c1 | c \break
  c1 | c \break
  c1 | c
}

\book {
  \score {
    \new GrandStaff <<
      \new Staff \notes 
      \new Staff \notes 
    >>
  }
}
