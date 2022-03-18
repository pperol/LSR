%% %% http://lsr.di.unimi.it/LSR/Item?id=554
%% see also http://lsr.di.unimi.it/LSR/Item?id=642
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-time-signature-in-parentheses-_002d-method-3

tsMarkup = \markup {
  \override #'(baseline-skip . 0.5)
  \column { \number 3 \note #"2" #-1 }
}

\relative c' {
  \override Staff.TimeSignature.style = #'default
  \override Staff.TimeSignature.stencil = #(lambda (grob)
    (grob-interpret-markup grob tsMarkup))
  \time 3/2
  c2 d4 e f2
  g1.
}
