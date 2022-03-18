%% http://lsr.di.unimi.it/LSR/Item?id=224
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/staff-symbol-properties

\new Staff \relative c' {
  \override Staff.StaffSymbol.line-positions = #'(-7 -2 0 3 9)
  g c f b e a
}
