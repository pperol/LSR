\header {
  title = "Ouvertûre"
  subtitle = "Zu Heinrich Joseph v. Collins Trauerspiel"
  subsubtitle = \markup { \large \bold "Coriolan" }
  opus = "Op. 62"
  piece = \markup { \large Allegro con brio }
  composer = "Ludwig van Beethoven (1770-1827)"
}

raisedFlat = \markup { 
  \hspace #-.5 %% \hspace added for v2.18
  \raise #0.4 \smaller \smaller \flat 
  \hspace #-.5 %% \hspace added for v2.18
} 
flauti = \relative c' {
  \set Staff.instrumentName = #"2 Flauti  "
  \set Staff.shortInstrumentName = #"Fl.  "
  \time 4/4
  c1
  \break 
  \pageBreak
  c
  %  \break c
  %  \break c
  \bar"|."
}

oboi = \relative c' {
  \set Staff.instrumentName = #"2 Oboi  "
  \set Staff.shortInstrumentName = #"Ob.  "
  c1 c
}

clarinetti = \relative c' {
  \set Staff.instrumentName = \markup { \column { "Clarinetti  "
  \line { "in B" \raisedFlat } } }
  \set Staff.shortInstrumentName = \markup { \smaller  { "Cl(B"
  \raisedFlat ")  " } }
  
  c1 c
}

fagotti = \relative c {
  \set Staff.instrumentName = #"2 Fagotti  "
  \set Staff.shortInstrumentName = #"Fg.  "
  \clef bass
  c1 c
}

corni = \relative c' {
  \set Staff.instrumentName = \markup { \column { "Corni  " \line {
  "in E" \raisedFlat } } }
  \set Staff.shortInstrumentName = \markup { \smaller  { "Cor(E"
  \raisedFlat ")  " } }
  c1 c
}

trombe = \relative c' {
  \set Staff.instrumentName = \markup \column { "2 Trombe  " "(C)  " }
  \set Staff.shortInstrumentName = \markup \column {  "Tbe.  " "(C)  " }
  c1 c
}

timpani = \relative c {
  \set Staff.instrumentName = \markup \column { "Timpani  " "(C-G)  " }
  \set Staff.shortInstrumentName = #"Timp.  "
  \clef bass
  c1 c
}

violinoI = \relative c' {
  \set Staff.instrumentName = #"Violino I  "
  \set Staff.shortInstrumentName = #"Vl. I  "
  c1 c
}

violinoII = \relative c' {
  \set Staff.instrumentName = #"Violino II  "
  \set Staff.shortInstrumentName = #"Vl. II  "
  c1 c
}

viola = \relative c' {
  \set Staff.instrumentName = #"Viola  "
  \set Staff.shortInstrumentName = #"Vla.  "
  \clef alto
  c1 c
}

violoncello = \relative c {
  \set Staff.instrumentName = \markup \column { "Violoncello  " "e"
  "Contrabasso  " }
  \set Staff.shortInstrumentName = \markup \column {  "Vc.  " "Cb.  " }
  \clef bass
  c1 c
}


\paper {
  indent = 10.0\mm
  line-width = 150.0\mm
  ragged-bottom = ##t
}

#(set-global-staff-size 16)
\book {
  \score {
    <<
      \new StaffGroup = "legni" <<
        \new Staff = "flauti" \flauti
        \new Staff = "oboi" \oboi
        \new Staff = "clarinetti" \clarinetti
        \new Staff = "fagotti" \fagotti
      >>
      \new StaffGroup = "ottoni" <<
        \new Staff = "corni" \corni
        \new Staff = "trombe" \trombe
      >>
      \new StaffGroup = "timpani" \with {
        \override SystemStartBracket.collapse-height = #4
      } <<
        \new Staff = "timpani" \timpani
      >>
      \new StaffGroup = "archi" <<
        \new GrandStaff = "violini" <<
          \new Staff = "violinoI" \violinoI
          \new Staff = "violinoII" \violinoII
        >>
        \new Staff = "viola" \viola
        \new Staff = "violoncello" \violoncello
      >>
    >>
    \layout {
      indent = 10.0\mm
      line-width = 150.0\mm
      ragged-bottom = ##t
      \context {
        \Staff \RemoveEmptyStaves
      }
    }
  }
}
