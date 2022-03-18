%% http://lsr.di.unimi.it/LSR/Item?id=165
%% see also http://lilypond.org/doc/v2.18/Documentation/learning/visibility-and-color-of-objects

%LSR odified by P.P.Schneider on Feb.2014

\score{
  \new Staff 
  \with { 
    \omit TimeSignature 
    % or:
    %\remove "Time_signature_engraver" 
  }
  { 
   c' d' e' f'  g' f' e'  d'  c' 
  }
} 
