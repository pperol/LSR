%% http://lsr.di.unimi.it/LSR/Item?id=618
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/simultaneous-notes


\relative c' {
  \clef alto
  \time 3/2
  d4 e f g a f << { d2 (cis4) } \\ { <a e'>2. } >> d2. \bar "||" 
  d4 e f g a f << 
    { \once \override NoteColumn.force-hshift = #1.3 d2( cis4) } 
    \\ 
    { <a e'>2. } 
  >> d2. 
  \bar "|."
}
