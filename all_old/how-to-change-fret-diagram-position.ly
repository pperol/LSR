%% http://lsr.dsi.unimi.it/LSR/Item?id=172

harmonies = \chordmode
{
  a8:13
% THE FOLLOWING IS THE COMMAND TO MOVE THE CHORD NAME
  \once \override ChordNames.ChordName.extra-offset = #'(10 . 0)
  b8:13 s2.
% THIS LINE IS THE SECOND METHOD
    s4 s4  b4:13
}

\score
{
  <<
    \context ChordNames \harmonies
    \context Staff
    {a8^\markup { \fret-diagram  #"6-x;5-0;4-2;3-0;2-0;1-2;"  }
% THE FOLLOWING IS THE COMMAND TO MOVE THE FRET DIAGRAM
     \once \override TextScript.extra-offset = #'(10 . 0)
     b4.~^\markup { \fret-diagram  #"6-x;5-2;4-4;3-2;2-2;1-4;"  } b4. a8\break
% HERE IS THE SECOND METHOD
     <<
       { a8 b4.~ b4. a8} 
       { s4 s4 s4^\markup { \fret-diagram  #"6-x;5-2;4-4;3-2;2-2;1-4;"  }
       }
     >>
   }
  >>
}
