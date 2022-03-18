%% http://lsr.dsi.unimi.it/LSR/Snippet?id=627
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/editorial-annotations

% NR 1.7 Editorial annotations

\include "english.ly"

% Beethoven, Op. 31, No. 3
% Piano sonata 18, Movt II, Scherzo
% Measures 9 - 14

\new PianoStaff <<

  % RH Staff
  \new Staff {
    \clef treble
    \key af \major
    \time 2/4
    \set Staff.fingeringOrientations = #'(up)
    \set Score.currentBarNumber = #9
    \partial 8
    <af''-4 c''>8 \staccato
    |
    \set doubleSlurs = ##t
    <bf''-5 df''-2>4 (
    <af''-4 c''>8 \staccato )
    \noBeam
    c''8-5 \staccato \pp
    |
    \set doubleSlurs = ##f
    bf'8.. (
    af'32
    g'8 ) \staccato
    f'8 \staccato
    |
    e'4-2
    r8
    \once \override Script.script-priority = #-100
    \afterGrace
    f'8 ( \trill ^ \markup { \finger "3-2" }
    { e'16 [ f'16 ] }
    |
    g'8..-3
    f'32
    e'8-1 ) \staccato
    d'8-2 \staccato
    |
    c'4
    r4
  }

  % LH Staff
  \new Staff {
    \key af \major
    \clef treble
    \override Fingering.direction = #down
    \set Staff.fingeringOrientations = #'(down)
    \partial 8
    <af' af>8 \staccato
    \set doubleSlurs = ##t
    <g'-2 ef'-3>4 (
    <af' af>8 ) \staccato
    \noBeam
    \clef bass
    c'8-1 \staccato
    |
    \set doubleSlurs = ##f
    bf8.. (
    af32
    g8-1 ) \staccato
    f8 \staccato
    |
    e4
    r8
    \afterGrace
    f8 ( \trill _ \markup { \finger "2-1" }
    { e16 [ f16 ] }
    |
    g8..-1
    f32
    e8 ) \staccato
    d8 \staccato
    |
    c4
    r4
  }
>>
