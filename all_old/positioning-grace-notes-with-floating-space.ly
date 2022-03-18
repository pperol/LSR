%% http://lsr.di.unimi.it/LSR/Item?id=557
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/special-rhythmic-concerns.html

\relative c'' {
  <<
    \override Score.SpacingSpanner.strict-grace-spacing = ##t
    \new Staff \new Voice {
      \afterGrace c4 { c16[ c8 c16] }
      c8[ \grace { b16 d } c8]
      c4 r
    }
    \new Staff {
      c16 c c c c c c c c4 r
    }
  >>
}
