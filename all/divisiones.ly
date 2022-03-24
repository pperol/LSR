\include "gregorian.ly"

\fixed c' {
	\set Score.timing = ##f
	\set Score.barAlways = ##t
	\override TextScript.padding = #3
	\hide Staff.BarLine
	\omit Stem
	g4( a) g^"divisio minima"
	\divisioMinima
	g4( a) g^"divisio maior"
	\divisioMaior
	g4( a) g^"divisio maxima"
	\divisioMaxima
	g4( a) g^"  finalis"
	\finalis
	g4( a) g^"virgula"
	\virgula
	g4( a) g^"caesura"
	\caesura
	g4( a) g
}
\addlyrics {
	Blah blub, blah blam.
	Blah blub, blah blam.
	Blah blub, blah blam.
	Blah blub.
}
