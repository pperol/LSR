%% http://lsr.dsi.unimi.it/LSR/Item?id=590
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats#repeats-percent-repeat-count-visibility

\relative c'' {
  \set countPercentRepeats = ##t
  \set repeatCountVisibility = #(every-nth-repeat-count-visible 5)
  \repeat percent 10 { c1 } \break
  \set repeatCountVisibility = #(every-nth-repeat-count-visible 2)
  \repeat percent 6 { c1 d1 }
}
