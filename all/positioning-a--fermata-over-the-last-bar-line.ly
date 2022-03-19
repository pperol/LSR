\relative c'' {
  \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
  c1 \mark \markup { \musicglyph #"scripts.ufermata" }
}

%{
%% A shorter incantation could be:

\relative c'' {
  c1 
  \tweak break-visibility #begin-of-line-invisible 
  \mark \markup { \musicglyph "scripts.ufermata" } 
}
%}
