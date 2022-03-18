%% http://lsr.di.unimi.it/LSR/Item?id=606
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/figured-bass

fb = \figuremode {
  s4 <6 4> <5 3> <7 _!> |
  s4 <6 4> <5 3> <7 _!> |
}

music = \relative c' {
  g4 c r e |
  g,4 c s e |
}

\new Score {
  <<
    % Figures above rests in figuremode inside a Staff context are printed:
    \new Staff <<
      \new Voice = "FiguredBass" { \fb }
      \new Voice = "Music" { \clef "bass" \music }
    >>
    % One has to set ignoreFiguredBassRest to ##t to print them:
    \new Staff \with { ignoreFiguredBassRest = ##t } <<
      \new Voice = "FiguredBass" { \fb }
      \new Voice = "Music" { \clef "bass" \music }
    >>
  >>
}
