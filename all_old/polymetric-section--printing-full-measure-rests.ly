%% http://lsr.dsi.unimi.it/LSR/Item?id=329
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms#polymetric-notation

\paper { 	
  ragged-right = ##t
}

\layout { 
  \context { 
    \Score
    \remove "Timing_translator"
    \remove "Time_signature_engraver"
    \remove "Default_bar_line_engraver"
    \override SpacingSpanner.uniform-stretching = ##t
    \override SpacingSpanner.strict-note-spacing = ##t
    proportionalNotationDuration = #(ly:make-moment 1/64)
  }
  \context { 
    \Staff
  \consists "Timing_translator"
  \consists "Time_signature_engraver"
  \consists "Default_bar_line_engraver"
  }
}

global = { 
  \set Timing.defaultBarType = ""
  \repeat unfold 4 { s4. } \bar "" \break
}

\new Score { <<
  \new StaffGroup { <<
    \new Staff <<
      \global
      {
        \time 3/8
        \repeat unfold 2 { R4. \bar "|" c'8[c'8 c'8] \bar "|" } 
      }
    >>
    \new Staff <<
      \global
      {
        \scaleDurations #'(4 . 9) { 
          \time 1/6
          \set Staff.timeSignatureFraction = #'(3 . 8)
          \repeat unfold 3 { R4. \bar "|" c'8[c'8 c'8] \bar "|" R4. \bar "|"}
        }	
      }
    >>
  >> }

>> }

