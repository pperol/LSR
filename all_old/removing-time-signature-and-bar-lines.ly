%% http://lsr.di.unimi.it/LSR/Item?id=123
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/visibility-of-objects

%LSR modified by P.P.Schneider on Feb.2014

\score {
  \new Staff \relative c'' {
    a4 b c d
    d4 c b a
  }
  \layout {
    ragged-right = ##t
    \context {
      \Staff
      \omit TimeSignature
       % or:
      %\remove "Time_signature_engraver"
      \omit BarLine
      % or:
      %\remove "Bar_engraver"
    }
  }
}
