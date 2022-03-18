%% http://lsr.di.unimi.it/LSR/Item?id=877
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/expressive-marks

\new Voice {
  << 
    { c''4.( d''8) }
    { s4 s\turn } 
  >> 
  \transpose c d << 
    { c''4.( d''8) }
    { 
      s4 
      \hideNotes
      \set suggestAccidentals = ##t
      \override AccidentalSuggestion.outside-staff-priority = ##f
      \override AccidentalSuggestion.avoid-slur = #'inside
      \override AccidentalSuggestion.font-size = #-3
      \override AccidentalSuggestion.script-priority = #-1
      b'8-\turn \noBeam 
      \set suggestAccidentals = ##f
      \unHideNotes
      s8
    } 
  >>
}
