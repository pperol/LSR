%% http://lsr.dsi.unimi.it/LSR/Item?id=295

\layout {
  \context {
    \DrumStaff     
    beamExceptions = #(cons '((4 . 4) . ((beamExceptions . ((end . (((1 . 8) . (2 2 2 2))))))))
                              default-time-signature-settings)
  }
}

up = \drummode {hh8 hh hh hh hh hh hh hh} %%No manual beaming indication, as you can see

down = \drummode {
  \override Beam.positions = #'(-5 . -5)
  bd8. bd16 sn16 bd8  bd16 r8 bd8 sn16 bd8. 
}

\new DrumStaff {
  <<
    \new DrumVoice { \voiceOne  \up }
    \new DrumVoice { \voiceTwo \down }
  >>
}
