%% http://lsr.di.unimi.it/LSR/Item?id=848
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-fretted-strings
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/fretted-strings
%LSR modified by P.P.Schneider on Feb.2014 for v2.18

%{ Tablature layout for viol music

The snippet defines a specialized group of rhythmic and
tablature staves able to handle old english viol tablature
scores.

The string tunings defaults to the most common viol in d
but other usual tunings are also available.

The rhythm part is used to provide only the pace changes,
and therefore must be provided as a supplementary voice.
%}

viol-in-d-tuning = \stringTuning <d, g, c e a' d'>

viol-in-d-scord-tuning = \stringTuning <c, g, c e a' d'>

viol-in-g-tuning = \stringTuning <g, c f a' d' g''>

ViolTabLayout = \layout {
  \context {
    \RhythmicStaff
    \type "Engraver_group"
    \name "ViolTabRhythmicStaff"
    \alias "RhythmicStaff"

    \description "Handles rhythm part of viol tablature."
  
    \remove "Time_signature_engraver"
    \remove "Staff_symbol_engraver"
    \remove "Bar_engraver"

    fontSize = #-3
    \override StaffSymbol.staff-space = #(magstep -3)
    \override Stem.length = #5
    \override VerticalAxisGroup.staff-staff-spacing =
      #'((basic-distance . 1)
         (minimum-distance . 1)
         (padding . 1))

    % useful to merge chords noteheads
    \override NoteHead.X-offset = #0
  }

  \context {
    \TabStaff
    \type "Engraver_group"
    \name "ViolTabFingeringStaff"
    \alias "Staff"

    \description "Handles fingering part of viol tablature."

    tablatureFormat = #fret-letter-tablature-format
    stringTunings = #viol-in-d-tuning

    % useful for tablature only scores
    \revert TimeSignature.stencil
    \override TimeSignature.style = #'single-digit
  }

  \context {
    \type "Engraver_group"
    \name "ViolTabStaff"
    \consists "Vertical_align_engraver"
    topLevelAlignment = ##f

    \description "Handles viol tablature."

    \defaultchild "ViolTabFingeringStaff"
    \accepts "ViolTabRhythmicStaff"
    \accepts "ViolTabFingeringStaff"
  }

  \context {
    \Score
    \accepts "ViolTabStaff"
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

myNotes  = \relative c  { <d, g d'>4 e f8 g a4 <d b g>2. c4 d4. e8 f4 g }
myRhythm = \relative c' {         a4 s a8 s a4       a2. a4 a4. a8 a4 s }

\score {
  <<
    \new Staff {
      \clef bass
      \myNotes
    }
    \new ViolTabStaff {
      <<
        \new ViolTabRhythmicStaff {
          %\myNotes
          \myRhythm
        }
        \new ViolTabFingeringStaff {
          \myNotes
        }
      >>
    }
  >>
  \layout {
    \ViolTabLayout
  }
}
