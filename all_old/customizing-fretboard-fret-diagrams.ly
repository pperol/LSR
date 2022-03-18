%% http://lsr.di.unimi.it/LSR/Item?id=576
%% see also http://www.lilypond.org/doc/v2.18/Documentation/internals/fretboard


\include "predefined-guitar-fretboards.ly"
\storePredefinedDiagram #default-fret-table \chordmode { c' }
                        #guitar-tuning
                        #"x;1-1-(;3-2;3-3;3-4;1-1-);"
<<
  \new ChordNames {
    \chordmode { c1 | c | c | d }
  }
  \new FretBoards {
    % Set global properties of fret diagram
    \override FretBoards.FretBoard.size = #'1.2
    \override FretBoard.fret-diagram-details.finger-code = #'in-dot
    \override FretBoard.fret-diagram-details.dot-color = #'white
    \chordmode {
      c
      \once \override FretBoard.size = #'1.0
      \once \override FretBoard.fret-diagram-details.barre-type = #'straight
      \once \override FretBoard.fret-diagram-details.dot-color = #'black
      \once \override FretBoard.fret-diagram-details.finger-code = #'below-string
      c'
      \once \override FretBoard.fret-diagram-details.barre-type = #'none
      \once \override FretBoard.fret-diagram-details.number-type = #'arabic
      \once \override FretBoard.fret-diagram-details.orientation = #'landscape
      \once \override FretBoard.fret-diagram-details.mute-string = #"M"
      \once \override FretBoard.fret-diagram-details.label-dir = #LEFT
      \once \override FretBoard.fret-diagram-details.dot-color = #'black
      c'
      \once \override FretBoard.fret-diagram-details.finger-code = #'below-string
      \once \override FretBoard.fret-diagram-details.dot-radius = #0.35
      \once \override FretBoard.fret-diagram-details.dot-position = #0.5
      \once \override FretBoard.fret-diagram-details.fret-count = #3
      d
    }
  }
  \new Voice {
    c'1 | c' | c' | d'
  }
>>
