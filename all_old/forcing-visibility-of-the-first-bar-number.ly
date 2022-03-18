%% http://lsr.dsi.unimi.it/LSR/Item?id=504
%% Modified by P.P.Schneider on Feb 15, 2014.

\layout { 
  \context { 
    \Score 
    % this line hereunder is just to fix a v2.18.0 bug
    % (see : http://lilypond.1069038.n5.nabble.com/Bar-number-on-odd-bars-does-not-work-on-new-release-td157263.html)
    barNumberVisibility = #(lambda (n x) (= (modulo n 1) 0)) 
  } 
} 

\relative c' {
  \override Score.BarNumber.font-size = #4
  \set Score.currentBarNumber = #11
  \bar ""
  c1
}
