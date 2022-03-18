%% http://lsr.dsi.unimi.it/LSR/Item?id=309

% Note what happens if \hspace #-2 is deleted or set to +n.
% If "tacet" instead of "Tacet" a little bit of "C" peeks around the \whiteout.
CMString  = { <c e g>-\markup { \whiteout { \hspace #-2 "Tacet" } } }
CMStringX = #(append (sequential-music-to-chord-exceptions CMString #t)
           ignatzekExceptions)
<< { \chords { c1
   \set   chordNameExceptions = #CMStringX c
   \unset chordNameExceptions c }
 }
 { \relative c'' { c c c } 
 } 
>>
