\header {
  texidoc = "
If you're not happy with the distance of the metronome sign from the
score, you can alter its position using the @code{padding} property of
@code{MetronomeMark}. 

"
  doctitle = "Distancing the metronome sign"
}
%% http://lsr.di.unimi.it/LSR/Item?id=13
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/style-sheets


{
  \tempo 4 = 60
  \repeat unfold 4 e''4
  \override Score.MetronomeMark.padding = #3
  \tempo 4 = 60
  \repeat unfold 4 e''4
} 

