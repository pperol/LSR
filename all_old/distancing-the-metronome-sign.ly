%% http://lsr.di.unimi.it/LSR/Item?id=13
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/style-sheets


{
  \tempo 4 = 60
  \repeat unfold 4 e''4
  \override Score.MetronomeMark.padding = #3
  \tempo 4 = 60
  \repeat unfold 4 e''4
} 
