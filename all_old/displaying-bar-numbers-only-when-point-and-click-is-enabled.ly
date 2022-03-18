%% http://lsr.di.unimi.it/LSR/Item?id=863

% uncomment the follwong line 
%\pointAndClickOff

initBarNumberVisibility =
  #(define-music-function
    (parser location)
    ()
    (if (ly:get-option 'point-and-click)
        #{
          \override Score.BarNumber.break-visibility = #'#(#t #t #t)
          % The following line makes bar numbers "invisible" to the collision-avoidance engine,
          % so that the preview & production scores should have identical spacing.
          \override Score.BarNumber.X-extent = #'(0 . 0)
        #}
        #{
          \override Score.BarNumber.break-visibility = #'#(#f #f #f)
        #})
    )
  
\score {
  \new Staff \relative c' {
    %\initBarNumberVisibility % Can be moved to the \layout block with later LilyPond versions
    \time 4/4
    c1*5 \break |
    c1*5 \break |
    c1*5 \bar "|." |
  }
  \layout {
    \context {
      \Score
      % I prefer this here, but it doesn't work in 2.14.2 (works in later versions, such as 2.16.1)
      \initBarNumberVisibility
    }
  }
}
