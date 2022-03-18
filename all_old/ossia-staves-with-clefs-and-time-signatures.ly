%% http://lsr.dsi.unimi.it/LSR/Item?id=774
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/modifying-single-staves#ossia-staves

\include "english.ly"

showMeter = { \once \revert Staff.TimeSignature.stencil }

outline = {
  \time 4/4 s1*2
  \showMeter \time 3/4 s2.
  \showMeter \time 4/4 s1*2
}

\score {
  <<
    \new Staff = "ossia" \with {
      \override Clef.stencil = ##f
      \override KeySignature.stencil = ##f
      \override TimeSignature.stencil = ##f
      fontSize = #-3
      \override StaffSymbol.staff-space = #(magstep -3)
      \override StaffSymbol.thickness = #(magstep -3)
    } {
      \stopStaff
      \outline
    }
    \new Staff <<
      \outline
      {
	\repeat unfold 16 { b'16 }
	<<
	  { \repeat unfold 60 { b'16 } }
	  \context Staff="ossia" {
	    \revert Staff.Clef.stencil
	    \startStaff
	    \repeat unfold 22 { b'8 }
	    \override Clef.stencil = ##f
	    \stopStaff
	  }
	>>
      }
    >>
  >>
}
