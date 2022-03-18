%% http://lsr.di.unimi.it/LSR/Item?id=783
%% http://lilypond.org/doc/v2.18/Documentation/notation/midi-instruments.fr.html

\score {
  <<
  \new ChordNames {
    \chordmode {
      d:min
    }
  }
  \new Staff {
    d'4 f'4 a'4 d''4
  }
  >>
  \layout {
  }  
  \midi {
    \context { 
      \ChordNameVoice \remove Note_performer 
    }
  }
}
