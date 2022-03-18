%% http://lsr.dsi.unimi.it/LSR/Item?id=483
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/chords#chords-manually-break-figured-bass-extenders-for-only-some-numbers

bassfigures = \figuremode {
  \set useBassFigureExtenders = ##t
  <6 4>4 <6 4\!> <6 4\!> <6 4\!> |  <6\! 4\!>  <6 4> <6 4\!> <6 4>
}

<<
  \new Staff \relative c'' { c1 c1 }
  \new FiguredBass \bassfigures
>>
