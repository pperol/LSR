\include "gregorian.ly"
voiceglobal = {
  \omit Dots
  \omit Tie
  \time 3/4
}
\score {
  <<
    \new VaticanaVoice = "voiceone" \relative c' {
      \voiceglobal
      \key f \major
      \clef "vaticana-do2"
      \[ \virga c1. \melisma \] \divisioMaior
      \[ e2 \flexa d4 \pes e2 \]
      \[ f4 \flexa d2. \]
      \[ \virga c2. \] \divisioMaior
      \[ e2 \flexa d4 \pes e2 \]
      \[ f4 \flexa d2. \]
      \[ \virga c2. \] \divisioMaior
      \[ a2 \pes bes4 \flexa a2 \]
      \[ bes4 \flexa g2. \]
      \[ \virga f2. \] \divisioMaior
      \[ \virga e'2. \] 
      \[ \virga c \]
      \[ \virga bes \]
      \[ \virga c \] \divisioMaior 
    }
    \new Lyrics \lyricsto "voiceone" {
      Vi
    }
    \new VaticanaVoice = "voicetwo" \relative c' {
      \voiceglobal
      \key f \major
      \clef "vaticana-do2"
      \[ \virga f1. \melisma \] \divisioMaior
      \[ e2 \flexa f4 \pes e2 \flexa f4 \pes e2. \]
      \[ \virga f \] \divisioMaior
      \[ e2 \flexa c4 \]
      \[ \virga c2 \]
      \[ bes4 \pes d2. \]
      \[ \virga c \] \divisioMaior
      \[ e2 \flexa f4 \pes e2 \flexa f4 \pes e2. \]
      \[ \virga f \] \divisioMaior
      \[ e2 \flexa c4 \]
      \[ c2 \flexa bes4 \pes d2. \]
      \[ \virga c2. \] \divisioMaior
    }
    \new Lyrics \lyricsto "voicetwo" {
      Vi
    }
    \new VaticanaVoice = "voicethree" \relative c' {
      \voiceglobal
      \clef "vaticana-do2"
      \key f \major
      \[ \virga c1. \melisma \] \divisioMaior
      \[ bes2 \pes c4 \flexa bes2 \pes c4 \flexa bes2. \]
      \[ \virga c2. \] \divisioMaior
      \[ e2 \pes f4 \flexa e2 \pes f4 \flexa e2. \]
      \[ \virga f \] \divisioMaior
      \[ e2 \flexa c4 \]
      \[ \virga c2 \]
      \[ bes4 \pes d2. \]
      \[ \virga c \] \divisioMaior
      \[ e2 \pes f4 \flexa e2 \pes f4 \flexa e2. \]
      \[ \virga f \] \divisioMaior
    }
    \new Lyrics \lyricsto "voicethree" {
      Vi
    }
    \new VaticanaVoice = "voicefour" \relative c {
      \voiceglobal
      \key c \major
      \clef "vaticana-do3"
      \[ \virga f1.~ \melisma \] \divisioMaior
      \hideNotes
      \repeat unfold 7 { f~ }
      f1.
    }
    \new Lyrics \lyricsto "voicefour" {
      Vi
    }
  >>
}
