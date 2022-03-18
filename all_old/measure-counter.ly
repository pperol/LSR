%% http://lsr.dsi.unimi.it/LSR/Item?id=473
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-measure-counter

<<
  \context Voice = "foo" {
    \clef bass
    c4 r g r
    c4 r g r
    c4 r g r
    c4 r g r
  }
  \context Voice = "foo" {
    \set countPercentRepeats = ##t
    \hide PercentRepeat
    \override PercentRepeatCounter.staff-padding = #1
    \repeat percent 4 { s1 }
  }
>>
