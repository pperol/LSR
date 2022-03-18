%% http://lsr.di.unimi.it/LSR/Item?id=616
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/fretted-strings#fretted-strings-string-number-extender-lines
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/spanners

stringNumberSpanner =
  #(define-music-function (parser location StringNumber) (string?)
    #{
      \override TextSpanner.style = #'solid
      \override TextSpanner.font-size = #-5
      \override TextSpanner.bound-details.left.stencil-align-dir-y = #CENTER
      \override TextSpanner.bound-details.left.text = \markup { \circle \number $StringNumber }
    #})


\relative c {
  \clef "treble_8"
  \stringNumberSpanner "5"
  \textSpannerDown
  a8\startTextSpan
  b c d e f\stopTextSpan
  \stringNumberSpanner "4" 
  g\startTextSpan a 
  bes4 a g2\stopTextSpan
}
