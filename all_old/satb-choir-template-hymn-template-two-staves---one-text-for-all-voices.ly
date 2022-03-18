%% http://lsr.dsi.unimi.it/LSR/Item?id=178

\header {  
  title = "Hymn Template"
  subtitle = ""
  tagline = ""   
  poet = ""
  composer = ""
}

#(set-global-staff-size 20)	
\include "english.ly"

upperOne = 
\relative a' {
  \time 4/4
  \voiceOne
  a4 b c d a b c d \break
}


upperTwo =  
\relative a' {
  \voiceTwo
  d,4 e f g d e f g
}


lowerOne = 	
\relative a {
  \time 4/4
  \voiceOne
  a4 b c d a b c d
  
} 

lowerTwo =   
\relative c {
  \voiceTwo
  d4 e f g d e f g
}

firstverse = \lyricmode {
  La la la la la la la la
}

secondverse = \lyricmode {
  Do do do do do do do do
}

thirdverse = \lyricmode {
  Re re re re re re re re
}

fourthverse = \lyricmode { }

refrain = \lyricmode {
  so so so so so
}

\score { 
  \context StaffGroup <<
    \context Staff = "upper" <<
      \clef treble
      \context Voice = "one" \upperOne
      \context Voice = "two" \upperTwo 
    >>
    \lyricsto "one" \new Lyrics {
      \set stanza = "1."
      \firstverse 
    }
    \lyricsto "one" \new Lyrics {
      \set stanza = "2."
      \secondverse 
    }
    \lyricsto "one" \new Lyrics {
      \set stanza = "3."
      \thirdverse 
    }
    \context Staff = "lower" <<
      \clef bass
      \context Voice = "one" \lowerOne
      \context Voice = "two" \lowerTwo
    >>
  >>
  \layout {
    \context {
      \Lyrics
      \override VerticalAxisGroup.nonstaff-relatedstaff-spacing = #'((padding . 1.2))
    }
    \context {
      \StaffGroup
      \remove "Span_bar_engraver"
    }
    \context {
      \Staff
     \override VerticalAxisGroup.staff-staff-spacing = #'((padding . 0))
      autoBeaming = ##t
      \unset melismaBusyProperties 
    }
    \context {
      \Score
      \remove "Bar_number_engraver"
    }
  }  
  \midi { }
}
\paper {
  line-width = 6\in 
  indent = 0
}



