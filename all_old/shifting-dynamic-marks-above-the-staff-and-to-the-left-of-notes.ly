%% http://lsr.di.unimi.it/LSR/Item?id=232
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-attached-to-notes#dynamics

\score {
  \new Staff <<
    \new Voice = melody \relative g'' {
  d4 \mp b c d |
  f \p b, c d' \fff |
  a, b\ppp c d  |
}
\new Lyrics \lyricsto melody { one two three four one two three four one two three four }
  >>
  \layout {
    \context {
      \Voice
% The self-alignment-X property tells LilyPond to position the marks on
% their right edges.
      \override DynamicText.self-alignment-X = #1
% The X-offset property normally is set to ly:self-alignment-interface::x-aligned-on-self,
% which is a function that says what the X-offset needs to be in order to align the mark
% on its right edge. Here we tell it instead to use a function that indicates an offset 1.2
% staff spaces to the left of right-alignment.  The 1.2 can be adjusted as needed to give
% different offsets.
      \override DynamicText.X-offset =
        #(lambda (grob)
           (- (ly:self-alignment-interface::x-aligned-on-self grob)
           1.2))
      \override DynamicLineSpanner.direction = #UP
    }
  }
}
