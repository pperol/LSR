%% http://lsr.di.unimi.it/LSR/Item?id=451
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/setting-the-staff-size

scordatura =  \markup {
  \raise #5.5 
  \score {
    \new Staff \with {
      \remove "Time_signature_engraver"
      fontSize = #-3
      \override StaffSymbol.staff-space = #(magstep -3)
    } {
      \set Staff.instrumentName= \markup \huge "Viol "
      \clef bass \cadenzaOn
      \override Stem.transparent = ##t
      <d a f c f, c>4 s \bar "||"
    }
    \layout {
      ragged-right = ##t
      indent = 1\cm
    }
  }
  \hspace #.5
}

notes = \relative c' {
  \clef alto
  \time 4/4
  c4 bes a g <f a>1 \bar "|."
}


\score {
  \new Staff <<
  \set Staff.instrumentName = \scordatura
  \new Voice  \notes
  >>
  \layout {
    ragged-right = ##t
    indent = 4\cm
  }
}
