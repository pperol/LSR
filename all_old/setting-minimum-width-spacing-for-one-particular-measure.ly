%% http://lsr.di.unimi.it/LSR/Item?id=629
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/horizontal-spacing-paper-variables.it.html

\paper {
  line-width = 9\cm
}

spacerVoice = \new Voice {
  \override MultiMeasureRest.transparent = ##t
  \override MultiMeasureRest.minimum-length = #8
  R1
}

\new Voice \relative c' {
  \dynamicUp
  << { c1 } { s2\f s2\p } >> | \noBreak
  f4 e d c | \noBreak
  << { c1 } { s2\f s2\p } \spacerVoice >> | \noBreak
  d2 e | \break
}
