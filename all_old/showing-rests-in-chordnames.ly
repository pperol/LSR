%% http://lsr.di.unimi.it/LSR/Item?id=529
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-chords

%LSR modified by P.P.Schneider on Feb. 2014

%LSR This snippet was provided by James Bailey for \version "2.22.0"

\layout {
  \context {
     \type "Engraver_group"
     \name ChordNamesRests
     \description "Typesets chord names."

     \consists "Output_property_engraver"
     \consists "Separating_line_group_engraver"
     \consists "Chord_name_engraver"
    
     \consists "Rest_engraver"
     
     noChordSymbol = ##f

     \override VerticalAxisGroup.staff-staff-spacing = #'((padding . 1))
     \override VerticalAxisGroup.remove-first = ##t
     \override VerticalAxisGroup.remove-empty = ##t
     
  }
  \context { \Score \accepts ChordNamesRests }
}

music = {
  c d e d
  f r g r
  c,1
}

\score {
  <<
     \new ChordNamesRests { 
       \chordmode { 
         \override Rest.extra-offset = #'(0 . 1) %% modif. Feb.2014 for v2.18
         \music 
       } 
     }
     \relative c' { \music }
  >>
}
