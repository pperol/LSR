%% http://lsr.di.unimi.it/LSR/Item?id=559
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms#rhythms-printing-bar-numbers-at-regular-intervals


\relative c' {
  \override Score.BarNumber.break-visibility = #end-of-line-invisible
  \set Score.currentBarNumber = #11
  % Permit first bar number to be printed
  \bar ""
  % Print a bar number every second measure
  \set Score.barNumberVisibility = #(every-nth-bar-number-visible 2)
  c1 | c | c | c | c
  \break
  c1 | c | c | c | c
}
