%% http://lsr.di.unimi.it/LSR/Item?id=304
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-lines#trills

\relative c'' {
  \override TrillSpanner.bound-details.left.text = \markup{ 
    \musicglyph #"scripts.trill" \raise #0.65 \teeny  \sharp }
  
  b1\startTrillSpan
  b1\stopTrillSpan
  
  \override TrillSpanner.bound-details.left.text = \markup{ 
    \musicglyph #"scripts.trill" \raise #0.65 \teeny  \flat }
  
  c1\startTrillSpan
  c1\stopTrillSpan
}
