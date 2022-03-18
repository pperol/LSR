%% http://lsr.di.unimi.it/LSR/Item?id=824
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/repeats#repeats-setting-the-double-repeat-default-for-volte

\relative c'' {
  \repeat volta 1 { c1 }
  \set Score.doubleRepeatType = #":..:"
  \repeat volta 1 { c1 }
  \set Score.doubleRepeatType = #":|.|:"
  \repeat volta 1 { c1 }
  \set Score.doubleRepeatType = #":|.:"
  \repeat volta 1 { c1 }
}
