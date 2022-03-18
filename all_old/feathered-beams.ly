%% http://lsr.dsi.unimi.it/LSR/Item?id=239
%% see also : http://www.lilypond.org/doc/v2.18/Documentation/notation/beams#feathered-beams
%% see also : http://www.lilypond.org/doc/v2.19/Documentation/notation/beams#feathered-beams

\score {
  \relative c''<<
    \new Staff {
      % Turn on feathered beams:
      \override Beam.grow-direction = #LEFT
      
      % Illustration of feathered beams and the \featherDurations
      % function.
      
      % Example of a beamed sequence:
      bes32\p\>[ ges d' bes, c' ges a ges \!]
      
      % When the factor is 4/4=1, you get the same as without \featherDurations
      \featherDurations #(ly:make-moment  4/4)
      { bes32\p\>[ ges d' bes, c' ges a ges \!] }
      
      % When the factor is >1, you get a ritardando-like placement of the
      % notes (and sound in the MIDI output).
      \featherDurations #(ly:make-moment  6/4)
      { bes32\p\>[ ges d' bes, c' ges a ges \!] }
      
      % When the factor is <1, you get accelerando, i.e. you should
      % really only use if when \override Beam.grow-direction = #RIGHT
      \featherDurations #(ly:make-moment  3/4)
      { bes32\p\>[ ges d' bes, c' ges a ges \!] }
      
      % Revert back to ordinary beams:
      \revert Beam.grow-direction
      bes32\p\>[ ges d' bes, c' ges a ges \!]
      
      % Get a single feathered beam, using \once \override:
      \once \override Beam.grow-direction = #LEFT
      bes32\p\>[ ges d' bes, c' ges a ges \!]
      bes32\p\>[ ges d' bes, c' ges a ges \!]
      
      % The \featherDurations function just adjusts the durations
      % of the notes and can be used without % feathered beams:
      \featherDurations #(ly:make-moment  6/4)
      { bes32\p\>[ ges d' bes, c' ges a ges \!] }
    }
  % Reference rhythm to compare to:
  \new Staff \repeat unfold 64 { c32 }
   >>
}
