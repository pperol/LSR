%% http://lsr.dsi.unimi.it/LSR/Item?id=466
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-keyboards
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines#arpeggio


\new PianoStaff <<
  \set PianoStaff.connectArpeggios = ##t
  \override PianoStaff.Arpeggio.stencil = #ly:arpeggio::brew-chord-bracket
  \new Staff {
    \relative c' {
      \key b \major
      \time 6/8
      b8-.(\arpeggio fis'-.\> cis-. e-. gis-. b-.)\!\fermata^\laissezVibrer
      \bar "||"
    }
  }
  \new Staff {
    \relative c' {
      \clef bass
      \key b \major
      <<
        {
          <a e cis>2.\arpeggio
        }
        \\
        {
          <a, e a,>2.
        }
      >>
    }
  }
>>
