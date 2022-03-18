%% http://lsr.di.unimi.it/LSR/Item?id=308
%% http://www.lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-as-curves


\score { 
  <<
    \new Voice = "melody" \relative c' {
      c8 e8
      \voiceOne << 
        { 
          d8 f8 \oneVoice 
        } 
        \new Voice { 
          \voiceTwo 
          \hideNotes 
          \slurDashed 
          \once \override Slur.line-thickness = #2.5
          d8( f8) 
          \unHideNotes 
        } 
      >>
      e8 g8 f8 a8
    }
    \new Lyrics \lyricsto "melody" {
      One two three four five six seven eight
    }
    \new Lyrics \lyricsto "melody" {
      One two Whee! \skip 4 that's a dashed slur!
    }
  >> 
}
