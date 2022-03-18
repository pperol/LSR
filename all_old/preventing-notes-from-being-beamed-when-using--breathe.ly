%% http://lsr.di.unimi.it/LSR/Item?id=403
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/rhythms

% Alternative definition of \breathe that also does \noBeam

% You can as well name this function "breathe", to replace the existing one.

breathenobeam =
#(define-music-function (parser location) ()
           (make-music 'EventChord
             'origin location
             'elements (list (make-music 'BreathingEvent)
                         (make-music 'BeamForbidEvent))))
\relative c'{
  c8^"Using default \breathe" 
  d e \breathe f g f e \breathe d
  
  
  c8^"Using the new one"
   d e \breathenobeam f g f e \breathenobeam d
  
  
  c8^"limitation: \breathe and \breathenobeam are just as bad"
  [ d e] \breathenobeam f g[ f e] \breathe d 
}
