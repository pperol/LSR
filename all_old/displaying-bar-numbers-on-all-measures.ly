%% http://lsr.di.unimi.it/LSR/Item?id=93
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/bars#bar-lines

\score{
  \relative c'{
    c1 c c
    \override Score.BarNumber.break-visibility = #end-of-line-invisible
    \break
    c c c
  }
  \layout{ raggedright = ##t }
}
