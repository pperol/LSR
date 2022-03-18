%% http://lsr.dsi.unimi.it/LSR/Item?id=277
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-making-some-staff-lines-thicker-than-the-others

{
  \override Staff.StaffSymbol.line-positions =
    #'(-4 -2 -0.2 0 0.2 2 4)
  d'4 e' f' g'
}
