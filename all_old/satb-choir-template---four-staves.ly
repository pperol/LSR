%% http://lsr.di.unimi.it/LSR/Item?id=727
%% see also http://lsr.di.unimi.it/LSR/Item?id=178
%% see also http://lsr.di.unimi.it/LSR/Item?id=177
%% see also http://www.lilypond.org/doc/v2.18/Documentation/learning/satb-on-four-staves

global = {
  \key c \major
  \time 4/4
  \dynamicUp
}
sopranonotes = \relative c'' {
  c2 \p \< d c d \f
}
sopranowords = \lyricmode { do do do do }
altonotes = \relative c'' {
  c2\p d c d
}
altowords = \lyricmode { re re re re }
tenornotes = {
  \clef "G_8" 
  c2\mp d c d
}
tenorwords = \lyricmode { mi mi mi mi }
bassnotes = {
  \clef bass 
  c2\mf d c d
}
basswords = \lyricmode { mi mi mi mi }

\score {
  \new ChoirStaff <<
    \new Staff <<
      \new Voice = "soprano" << 
        \global 
        \sopranonotes 
      >>
      \lyricsto "soprano" \new Lyrics \sopranowords
    >>
    \new Staff <<
      \new Voice = "alto" <<
        \global 
        \altonotes 
      >>
      \lyricsto "alto" \new Lyrics \altowords
    >>
    \new Staff <<
      \new Voice = "tenor" << 
        \global 
        \tenornotes 
      >>
      \lyricsto "tenor" \new Lyrics \tenorwords
    >>
    \new Staff <<
      \new Voice = "bass" << 
        \global 
        \bassnotes 
      >>
      \lyricsto "bass" \new Lyrics \basswords
    >>
  >>
}



