%% http://lsr.di.unimi.it/LSR/Item?id=429
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/displaying-staves#grouping-staves
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-use-square-bracket-at-the-start-of-a-staff-group

\score {
  \new StaffGroup { << 
  \set StaffGroup.systemStartDelimiter = #'SystemStartSquare
    \new Staff { c'4 d' e' f' }
    \new Staff { c'4 d' e' f' }
  >> }
}
