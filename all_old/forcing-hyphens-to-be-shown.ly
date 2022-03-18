%% http://lsr.dsi.unimi.it/LSR/Item?id=680
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/vocal-music

\relative c'' {
  c32 c c c 
  c32 c c c 
  c32 c c c 
  c32 c c c 
}
\addlyrics {
  syl -- lab word word
  \override LyricHyphen.minimum-distance = #1.0
  syl -- lab word word
  \override LyricHyphen.minimum-distance = #2.0
  syl -- lab word word
  \revert LyricHyphen.minimum-distance
  syl -- lab word word
}
