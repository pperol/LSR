%% http://lsr.di.unimi.it/LSR/Item?id=686
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-removing-bar-numbers-from-a-score

\relative c' { 
  \new StaffGroup <<
    \new Staff {
      e1 | e
      \once \override Staff.BarLine.allow-span-bar = ##f
      e1 | e | e
    }
    \new Staff {
      c1 | c | c
      \once \override Staff.BarLine.allow-span-bar = ##f
      c1 | c
    }
    \new Staff {
      a1 | a | a | a | a
    }
  >>
}
