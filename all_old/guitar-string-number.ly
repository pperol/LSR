%% http://lsr.dsi.unimi.it/LSR/Item?id=217
%% see also : http://lilypond.org/doc/v2.18/Documentation/internals/stringnumber
%% see also : http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-fretted-strings#string-number-indications

\relative c' {
  \set fingeringOrientations = #'(down left up)
  \set stringNumberOrientations = #'(down right up)
  <c\5>4
  <e\4>
  <g\3>2
  <c,\5 e\4 g\3>1
}
