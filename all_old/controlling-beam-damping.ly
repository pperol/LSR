%% http://lsr.di.unimi.it/LSR/Item?id=375
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/user-backend-properties

%LSR contributed by James Lowe, after http://lists.gnu.org/archive/html/lilypond-user/2008-11/msg00629.html

notes = {
  \repeat unfold 5 { f,16 e' d' c' }
  \repeat unfold 5 { a16 c, e, c }
  \repeat unfold 5 { b16 f' c' g' }
  \repeat unfold 5 { d,16 g c f }
  \repeat unfold 5 { e,16 g b d }
  \repeat unfold 5 { g,16 a b c }
  \repeat unfold 5 { \stemDown d,16 a' e' b' }
}

damping = \repeat unfold 7 {
  %% default beam damping is 1:
  \override Beam.damping = #1 s4^"1 (def.)"
  \override Beam.damping = #2 s^"2"
  \override Beam.damping = #4 s^"4"
  \override Beam.damping = #-3 s^"-3"
  \override Beam.damping = #+inf.0 s^"+inf.0"
}

\score {
  \relative c' {
    \time 5/4
    \override Staff.TimeSignature.stencil = ##f
    <<
      \notes
      \damping
    >>
  }
  \layout {
    indent = #0
    system-count = #7
    ragged-right = ##t
  }
}
