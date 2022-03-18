%% http://lsr.dsi.unimi.it/LSR/Item?id=119
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/typesetting-mensural-music

\score {
  {
    \relative c'' {
      \override NoteHead.style = #'mensural
      c\maxima*1/8
      c\longa*1/4 c\breve*1/2 c1 c2 c4 c8 
    }
  }
}

