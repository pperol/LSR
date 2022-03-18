%% http://lsr.di.unimi.it/LSR/Item?id=636
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-text
%% see also http://lsr.di.unimi.it/LSR/Item?id=432


\relative c'' {  
  g2 c
  d,2 a'
  \once \override Score.RehearsalMark.break-visibility = #end-of-line-visible
  \once \override Score.RehearsalMark.self-alignment-X = #RIGHT
  \mark "D.C. al Fine"
  \break
  g2 b,
  c1 \bar "||"
}
