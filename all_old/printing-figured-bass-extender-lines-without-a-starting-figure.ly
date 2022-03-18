%% http://lsr.di.unimi.it/LSR/Item?id=607
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/figured-bass

fb = \figuremode {
  \bassFigureExtendersOn
  s4 <5> <5> <5> |
}

music = \relative c' {
  c4 c b c |
}

\new Score { <<
    % By declaring <5> to be an implicit figure,
    % the 5 is not printed, but extenders are...
    % Staff-wide setting:
    \new Staff \with { implicitBassFigures = #'(5) } <<
      \new Voice = "FiguredBass" { \fb }
      \new Voice = "Music" { \clef "bass" \music }
    >>
    % Using \set, this can be changed anywhere inside
    % the score for only a portion of the score
    \new Staff <<
      \set Staff.implicitBassFigures = #'(5)
      \new Voice = "FiguredBass" { \fb }
      \new Voice = "Music" { \clef "bass" \music }
    >>
  >>
}
