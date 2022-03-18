%% http://lsr.di.unimi.it/LSR/Item?id=345
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/vocal-music

sopranonotes = \relative c' { e2     e4  }
sopranowords = \lyricmode   { do2    me4 }

altonotes    = \relative c' { e4  e  e   }
altowords    = \lyricmode   { do4 re me  }

tenornotes   = \relative c  { e4  e  e   }
tenorwords   = \lyricmode   { do4 re me  }

bassnotes    = \relative c  { e4  e  e   }
basswords    = \lyricmode   { do4 re me  }

\score
{
  \context ChoirStaff
  <<
    \context Staff = soprano
    <<
      \context Voice = sop   { \clef treble \key c \major \time 4/4 \sopranonotes }
      \new Lyrics \lyricmode { \set associatedVoice = #"sop" \sopranowords }
    >>
    \context Staff = alto
    <<
      \context Voice = alt   { \clef treble \key c \major \time 4/4 \altonotes }
      \new Lyrics \lyricmode { \set associatedVoice = #"alt" \altowords }
    >>
    \context Staff = tenor
    <<
      \context Voice = ten   { \clef "G_8"  \key c \major \time 4/4 \tenornotes }
      \new Lyrics \lyricmode { \set associatedVoice = #"ten" \tenorwords     }
    >>
    \context Staff = bass
    <<
      \context Voice = bas   { \clef bass   \key c \major \time 4/4 \bassnotes }
      \new Lyrics \lyricmode { \set associatedVoice = #"bas" \basswords }
    >>
  >>
}
