%% http://lsr.di.unimi.it/LSR/Item?id=301
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/aligning-objects

\paper{ 
  indent = 0
}

\new PianoStaff <<
  \new Staff {
    \override Score.RehearsalMark.self-alignment-X = #left
    R1 R1 
    \mark \markup { "long markup with default horizontal extent" } 
    R1*2 
  }
  \new Staff {
    \repeat unfold 16 {
      \clef F
      c4
    }		
  }
>>

\new PianoStaff <<
  \new Staff {
    \override Score.RehearsalMark.self-alignment-X = #left
    R1 R1 
    \mark \markup { "long markup with default horizontal extent" } 
    \override Score.RehearsalMark.X-extent = #'(0 . 0)
    R1*2 
  }
  \new Staff {
    \repeat unfold 16 {
      \clef F
      c4
    }		
  }
>>

