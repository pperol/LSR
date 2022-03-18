%% http://lsr.di.unimi.it/LSR/Item?id=656
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/graphic

BachAccentFallendFromGrace =
{
  \once \override NoteHead.stencil =
  #(lambda (grob)
          (grob-interpret-markup grob
            (markup #:raise 0.2 #:large #:musicglyph "scripts.lcomma")))
  \once \override Stem.stencil = ##f
  \once \override Flag.stencil = ##f  
  \once \override Stem.length = #0  
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

timeKey = {
  \key d \major
  \time 3/8
}

firstPart = {
  a'16( g' fis' e' fis' d') |  
  a'8( b' cis''16\mordent d'') |
  
%%%%%%%%% Here is the example use
  
  cis''8 
  \BachAccentFallendFromGrace
  
  \grace b'8^( a'8) d'' |
  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  d''8 d' d'' |
  d''8 d' d'' |
  \bar "|."  
}

secondPart = {
  r8 r8 d16 e |
  fis16( e g fis e d) |
  a16( g fis e fis d) |
  a16( fis b g fis e) |
  a16( fis g e d cis) |
  \bar "|."  
}


\score {  
  \new PianoStaff = Keyboard <<    
    \new Staff = "upper" <<
      \timeKey
      \clef treble
      \new Voice = "first" { \firstPart \bar "|." }
    >>
    
    \new Staff = "lower" <<
      \timeKey
      \clef bass
      \new Voice = "second" { \secondPart \bar "|." }
    >>    
  >>
  \layout {
    \context {
      \Score
      % Prevents hidden grace from influencing spacing in lower staff
      % but can be left out if other grace notes are affected
      \override SpacingSpanner.strict-grace-spacing = ##t
    }
  }
}
