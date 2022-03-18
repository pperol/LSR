%% http://lsr.dsi.unimi.it/LSR/Item?id=712

%LSR modified/updated by P.P.Schneider on Feb 15, 2014.

\layout { 
  \context { 
    \Score 
    barNumberVisibility = #all-bar-numbers-visible 
    % this line hereunder is just to fix a v2.18.0 bug (P.P.Schneider Feb.2014)
    % (see : http://lilypond.1069038.n5.nabble.com/Bar-number-on-odd-bars-does-not-work-on-new-release-td157263.html)
    barNumberVisibility = #(lambda (n x) (= (modulo n 2) 1)) 
    % for higher version use :
    %barNumberVisibility = #(modulo-bar-number-visible 2 1) % or 2 0 to see the even bar numbers 
    \override BarNumber.break-visibility = #all-visible 
  } 
} 

\new Staff { 
  \bar ""
  \repeat unfold 8 { c'2 c' } 
}
