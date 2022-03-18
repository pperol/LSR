%% http://lsr.di.unimi.it/LSR/Item?id=540
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-curves

\relative c'' {
  \override TextScript.avoid-slur = #'inside
  \override TextScript.outside-staff-priority = ##f
  c2(^\markup { \halign #-10 \natural } d4.) c8
}
