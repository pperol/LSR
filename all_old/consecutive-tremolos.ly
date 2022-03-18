music = \relative c' {
  c4:16 d2: e4:
  f1:  
  g8: f: e: d: d2:
}

musicMidi = \relative c' {
  \repeat tremolo 4 c16 
  \repeat tremolo 8 d
  \repeat tremolo 4 e
  \repeat tremolo 16 f
  \repeat tremolo 2 { g f e d }
  \repeat tremolo 8 d
}

\score {
  \new Staff { 
    \music 
    %\musicMidi
  }
}

\score {
  \new Staff \relative c' {
    \unfoldRepeats
%% Tremolos entered with ‘:[number]’ are not are reflected in the MIDI output :
  % \music 
   \musicMidi
  }
  \midi { }
}
