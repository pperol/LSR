%% http://lsr.di.unimi.it/LSR/Item?id=432
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-text
%% see also http://lsr.di.unimi.it/LSR/Item?id=636

\relative c'' {  
  \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
  g2 c
  d,2 a'
  \mark \default
  \break
  g2 b,
  c1 \bar "||"
  \override Score.RehearsalMark.self-alignment-X = #RIGHT  
  \mark "D.C. al Fine"
}
