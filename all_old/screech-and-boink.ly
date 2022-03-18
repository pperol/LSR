%% http://lsr.di.unimi.it/LSR/Item?id=823
%% see also http://lilypond.org/doc/v2.18/Documentation/usage/an-example-of-a-musicological-document.fr.html

\score {
  \context PianoStaff <<
    \new Staff = "up" {
      \time 4/8
      \key c \minor
      <<
        {
          \revert Stem.direction
          \change Staff = down
          \set subdivideBeams = ##t
          g16.[
          \change Staff = up
          c'''32
          \change Staff = down
          g32
          \change Staff = up
          c'''32
          \change Staff = down
          g16]
          \change Staff = up
          \stemUp
          \set followVoice = ##t
          c'''32([ b''16 a''16 gis''16 g''32)]
        }
        \\
        { s4 \tuplet 3/2 { d'16[ f' g'] } as'32[ b''32 e'' d''] }
        \\
        { s4 \autoBeamOff d''8.. f''32  }
        \\
        { s4 es''4 }
      >>
    }
    \new Staff = "down" {
      \clef bass
      \key c \minor
      \set subdivideBeams = ##f
      \override Stem.french-beaming = ##t
      \override Beam.beam-thickness = #0.3
      \override Stem.thickness = #4.0
      g'16[ b16 fis16 g16]
      <<
        \makeClusters {
          as16 <as b> <g b> <g cis>
        }
        \\
        {
          \override Staff.Arpeggio.arpeggio-direction = #DOWN
          <cis, e, gis, b, cis>4\arpeggio
        }
      >>
    }
  >>
  \midi {
    \tempo 8 = 60
  }
  \layout {
    ragged-right = ##t
    \context {
      \Staff
      \consists "Horizontal_bracket_engraver"
    }
  }
}

