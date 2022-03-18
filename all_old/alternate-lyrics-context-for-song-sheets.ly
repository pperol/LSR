%% http://lsr.di.unimi.it/LSR/Item?id=641
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/vocal-music

%% Implement an alternate lyric context
\layout {
  \context {
    \Lyrics
    \name AltLyrics
    \alias Lyrics
    \override StanzaNumber.font-series = #'medium
    \override LyricText.font-shape = #'italic
    \override LyricText.color = #(x11-color 'grey20)
  }
  \context {
    \StaffGroup
    \accepts AltLyrics
  }
}

%% Doesn't do a lot, apart from avoid warnings when generating midi output
\midi {
  \context {
    \Lyrics
    \name AltLyrics
    \alias Lyrics
  }
  \context {
    \StaffGroup
    \accepts AltLyrics
  }
}

<<
  \new Staff {
    \new Voice = "notes" \relative c' {
      f4 a a a
    }
  }
  \new Lyrics \lyricsto "notes" {
    \set stanza = #"1."
    Hey non -- ny no
  }
  \new AltLyrics \lyricsto "notes" {
    \set stanza = #"2."
    Fa la la la
  }
  \new Lyrics \lyricsto "notes" {
    \set stanza = #"3."
    Fid -- dle di dee
  }
  \new AltLyrics \lyricsto "notes" {
    \set stanza = #"4."
    Da da da dum
  }
>>
