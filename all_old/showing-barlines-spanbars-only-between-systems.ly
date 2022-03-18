%% see http://lsr.di.unimi.it/LSR/Item?id=320
%% see also http://lilypond.org/doc/v2.18/Documentation/internals/span_002dbar_002dinterface

\relative c' \new StaffGroup <<
  \new Staff {
    a1
    \once \override Score.BarLine.transparent = ##t
    a1
    \once \override Score.SpanBar.transparent = ##t
    a1 a1
    \bar "|."
  }
  \lyricmode <<
    \new Lyrics { bla1 die bla }
    \new Lyrics { foo bar foo }
  >>
  \new Staff {
    f1 f1 f1 f1
  }
>>
