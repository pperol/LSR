%% http://lsr.dsi.unimi.it/LSR/Item?id=223
%% see also http://www.lilypond.org/doc/v2.18/Documentation/learning/aligning-lyrics-to-a-melody
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/vocal-music
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/techniques-specific-to-lyrics
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/vocal-music

<<
  \new Voice = "bla" \relative c'' {
    \autoBeamOff
    c2( d4) e8[ c b c] f4
  }
  \lyricsto "bla"  \new Lyrics { 
    bla ab blob blob 
  }
  \lyricsto "bla"  \new Lyrics {
    bla 

    \set ignoreMelismata = ##t
    
    blob

    %% note: effect of ignoreMelismata delayed one time step.
    \unset ignoreMelismata 
    blob
    
    blob
  }
  
  \lyricsto "bla"  \new Lyrics {
    nes ted lyrics voice with more words than no tes
  }
>>
  