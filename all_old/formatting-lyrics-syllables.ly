%% http://lsr.dsi.unimi.it/LSR/Item?id=373

%LSR Tip taken from http://lists.gnu.org/archive/html/lilypond-user/2007-12/msg00215.html

mel = \relative c'' { c4 c c c }
lyr = \lyricmode {
  Lyrics \markup { \italic can } \markup { \with-color #red contain }
  \markup { \fontsize #8 \bold Markup! }
}

<<
  \new Voice = melody \mel
  \new Lyrics \lyricsto melody \lyr
>>
