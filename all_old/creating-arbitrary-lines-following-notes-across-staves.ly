%% http://lsr.di.unimi.it/LSR/Item?id=729
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/voicefollower

\score {
  \new StaffGroup {
    \set StaffGroup.followVoice = ##t
    <<
      \new Staff=one {
        \override VoiceFollower.style = #'dashed-line
          <<
            {c'1}
            {s2 \change Staff = "three" b2} 
          >>
        a2 s2
        }
      \new Staff=two {
        \override VoiceFollower.style = #'dashed-line
        g'2 f' \change Staff = "one" e'1
      }
      \new Staff=three {
        s1 s
      }
    >>
  }
}
