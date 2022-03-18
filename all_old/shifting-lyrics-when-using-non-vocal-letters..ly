%% http://lsr.di.unimi.it/LSR/Item?id=737
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/lyrictext
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music

left = { \once \override LyricText.X-offset = #-2.8 }

\relative c' { 
  c4 c d8 g e4 
}

\addlyrics { 
  \left "S to" -- bom pu -- tu -- jem 
}
