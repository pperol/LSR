%% http://lsr.di.unimi.it/LSR/Item?id=169
%% see also http://lsr.di.unimi.it/LSR/Item?id=733
%% see also http://lsr.di.unimi.it/LSR/Item?id=734
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/staff-notation#staff-notation-time-signature-in-parentheses-_002d-method-3

\relative c'' {
  \override Staff.TimeSignature.stencil = #(lambda (grob)
    (bracketify-stencil (ly:time-signature::print grob) Y 0.1 0.2 0.1))
  \time 2/4
  a4 b8 c
}
