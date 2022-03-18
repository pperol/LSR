%% http://lsr.di.unimi.it/LSR/Item?id=387
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/spacing#spacing-vertically-aligned-dynamics-and-textscripts

music = \relative c' {
  a'2\p b\f 
  e4\p f\f\> g, b\p
  c2^\markup { \huge gorgeous } c^\markup { \huge fantastic }
}

{
  \music 
  \break
  \override DynamicLineSpanner.staff-padding = #2.0
  \override DynamicLineSpanner.Y-extent = #'(-1.5 . 1.5)
  \textLengthOn
  \override TextScript.Y-extent = #'(-1.5 . 1.5)
  \music
}
