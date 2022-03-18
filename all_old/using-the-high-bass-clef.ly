%% http://lsr.di.unimi.it/LSR/Item?id=855
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/displaying-pitches#clef

%LSR modified by P.P.Schneider on Feb.2014 for v2.18

MusicInF = {
  c'1
  \tag #'HornClefChanges {
    % switch to the High Bass Clef 
    \clef "bass^[8]"
    
    % As it's the first time the High Bass Clef appears,
    % I want to tell everyone "I'm using the High Bass Clef in this instrument part!"
  }
  c
  \tag #'HornClefChanges {
    \clef treble
  }
  d'
  \tag #'HornClefChanges {
    % the other way to select the High Bass Clef:
    % first, select the Octave Up Bass Clef
    \clef "bass"
    % and then cancel the octavtion number
    \set Staff.clefTransposition = #0
  }
  e
}

<<
  { s4*0^"French Horn in F, or Basset Horn"
    _\markup { \tiny \override #'(baseline-skip . 2) \column {
     \line { "In this example an" \italic "octavation eight in brackets" }
     \line { "is put over the first occurrence of the" \italic "high bass" }
     \line { \italic "clef" "as an editorial note to indicate: this music" }
     \line { "is still using the old-fashioned high bass clef." }
    } }
    \clef treble
    \MusicInF
  }
  { s4*0^"sounds as"
    \clef bass
    \transpose c f,
    \removeWithTag #'HornClefChanges
    \MusicInF
  }
>>
