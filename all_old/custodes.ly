%% http://lsr.di.unimi.it/LSR/Item?id=208
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/typesetting-mensural-music.html


\layout { ragged-right = ##t }

\new Staff \with { \consists "Custos_engraver" } \relative c' {
  \override Staff.Custos.neutral-position = #4
  
  \override Staff.Custos.style = #'hufnagel
  c1^"hufnagel" \break
  <d a' f'>1
  
  \override Staff.Custos.style = #'medicaea
  c1^"medicaea" \break
  <d a' f'>1
  
  \override Staff.Custos.style = #'vaticana
  c1^"vaticana" \break
  <d a' f'>1
  
  \override Staff.Custos.style = #'mensural
  c1^"mensural" \break
  <d a' f'>1
}
