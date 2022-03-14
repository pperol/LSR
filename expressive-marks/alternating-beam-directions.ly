\version "2.18.0"

\header {
  texidoc = "
The eighth notes may be seemingly attached to different
    beams, and the corresponding notes connected by ties. 
    Such a situation may occur, for example, in the cello suites. 

"
  doctitle = "Alternating beam directions"
}
%% http://lsr.di.unimi.it/LSR/Item?id=94
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/beams

wipeNote = {
  \once \override NoteHead.transparent = ##t
  \once \override Stem.transparent = ##t 
}

\layout { raggedright = ##t }

\relative c''<< 
  {
    c8[~ \wipeNote c c~ \wipeNote c c]~ \wipeNote c\noBeam
  } \\ { 
    s8 c[ s c s c] 
  } 
>>

