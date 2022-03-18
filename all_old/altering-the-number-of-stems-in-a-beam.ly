%% http://lsr.di.unimi.it/LSR/Item?id=98
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/beams

\new Voice
\relative c' {
  \set Timing.beamExceptions =
  #'(                         
     (end .                   
      (                       
       ((1 . 32) . (4 4 4 4 4 4 4 4))   
      ))) 
  f32 g a b b a g f

  f32 g a
  \set stemRightBeamCount = #1 b
  \set stemLeftBeamCount = #1 b
  a g f
}