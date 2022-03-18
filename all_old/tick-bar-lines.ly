%% http://lsr.di.unimi.it/LSR/Item?id=512
%% see also http://lsr.di.unimi.it/LSR/Item?id=89
%% see also : http://www.lilypond.org/doc/v2.18/Documentation/notation/bars.fr.html

\relative c' {
  \set Score.defaultBarType = #"'"
  c4 d e f
  g4 f e d
  c4 d e f
  g4 f e d
  \bar "|."
}
