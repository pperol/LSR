%% http://lsr.dsi.unimi.it/LSR/Item?id=288
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/text


raisedFlat = \markup { \translate #(cons -0.4 0.5) \smaller \flat  }

\new Staff {
  \set Staff.instrumentName = \markup { 
    \center-column  {
      \line {  Solo Clar. }   
      \line { "in B"\raisedFlat } 
    }
  }
  \relative c' { 
    des1^\markup { "D" \translate #(cons -0.3 0.4) \flat "major" } ~  | des | 
    dis1^\markup { "D" \translate #(cons -0.3 0.9) \sharp "minor" } ~ | dis1 
    \bar "||"
 } 
}

\paper {
  ragged-right = ##t 
}
