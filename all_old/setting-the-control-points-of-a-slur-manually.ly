%% http://lsr.di.unimi.it/LSR/Item?id=134
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/modifying-shapes

\score {
  \new PianoStaff
  <<
    \context Staff = "up" {
      \clef bass
      s1 * 4
    } 
    \context Staff = "down" \relative c 
    <<
      s1*4
      {
        \clef bass
        r4 r8
        \once\override Slur.extra-offset = #'(0 . 6)
        \once\override Slur.control-points =
        #'((0 . -4) (2 . 0) (60 . 0) (63 . 4))
        c8( as' f c' as
        
        % line breaks will mess up this example  
        \noBreak
        f c as' f
        \change Staff = up
        \clef treble
        c' as f' c
        \noBreak
        as' f c' as
        f' c as' f c'4)
      }
    >>
  >>
  \layout { }
}
