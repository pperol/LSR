%% http://lsr.di.unimi.it/LSR/Item?id=99
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/editorial-annotations#editorial-annotations-drawing-boxes-around-grobs


\relative c'' {
  \override TextScript.stencil =
    #(make-stencil-boxer 0.1 0.3 ly:text-interface::print)
  c'4^"foo"

  \override Stem.stencil =
    #(make-stencil-boxer 0.05 0.25 ly:stem::print)
  \override Score.RehearsalMark.stencil =
    #(make-stencil-boxer 0.15 0.3 ly:text-interface::print)
  b8
  
  \revert Stem.stencil
  \revert Flag.stencil
  c4. c4
  \mark "F"
  c1
}
