%% http://lsr.di.unimi.it/LSR/Item?id=742
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines

staffPiano = \new PianoStaff {
  \time 3/4
  <<
    \context Staff = "RH" {
      \clef treble
      \relative c' {
         c4 r4 \skip 4
      }
    }

    \context Staff = "LH" {
      \clef bass
      \relative c {
        \override VoiceFollower.style = #'zigzag 
        g2
        \showStaffSwitch
        \change Staff = "RH"
        <b'' d>4
        \hideStaffSwitch
        \change Staff = "LH"
      }
    }
  >>
}

\score {
  <<
    \staffPiano
  >>
}
