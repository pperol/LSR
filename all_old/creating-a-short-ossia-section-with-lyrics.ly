%% http://lsr.di.unimi.it/LSR/Item?id=846
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/lyrics

\score {
  \new ChoirStaff = "choirStaff" <<
    \new Staff = "sopranoStaff" {
      \new Voice = "sopranoVoice" {
        \compressFullBarRests
        R1*5
	<<
          R1
          \new Staff = "soloStaff"
          \with {
            \remove "Time_signature_engraver"
            alignAboveContext = #"sopranoStaff"
            fontSize = #-3
            \override StaffSymbol.staff-space = #(magstep -3)
            \override StaffSymbol.thickness = #(magstep -3)
          }
            \new CueVoice = "soloVoice" {
              \relative c'' {
                c4 c c c16[ c c
                % workaround for issue 1551
                c16*1/2] \hideNotes c32 |
              }
            }
            \new Lyrics = "soloLyrics"
            \with {
              alignBelowContext = "soloStaff"
              \override LyricText.font-size = #-3
            }
            \lyricsto "soloVoice"
            { Rea -- dy choir! Go for it now! }
        >>
        \relative c'' {
          b4 b b b |
          c4 c c c |
	}
      }
    }
    \new Lyrics = "sopranoLyrics" \lyricsto "sopranoVoice" {
      and here we are! La la la la
    }
    \new Staff = "altoStaff" {
      \new Voice = "altoVoice" {
        \relative c'' {
          R1*5
          R1
          b4 b b b |
          c4 c c c |
        }
      }
    }
  >>
}
