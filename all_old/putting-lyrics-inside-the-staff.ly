%% http://lsr.di.unimi.it/LSR/Item?id=723
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music#vocal-music-putting-lyrics-inside-the-staff

% LSR : contributed by Jan-Peter Voigt http://lists.gnu.org/archive/html/lilypond-user/2010-10/msg00451.html

<<
  \new Staff <<
    \new Voice = "voc" \relative c' { \stemDown a bes c8 b c4 }
  >>
  \new Lyrics \with {
    \override LyricText.extra-offset = #'(0 . 8.6)
    \override LyricExtender.extra-offset = #'(0 . 8.6)
    \override LyricHyphen.extra-offset = #'(0 . 8.6)
  } \lyricsto "voc" { La la -- la __ _ la }
>>
