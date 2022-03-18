%% http://lsr.di.unimi.it/LSR/Item?id=854
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/bars#bar-numbers
%% see also http://lsr.di.unimi.it/LSR/Item?id=712
%% see also http://lsr.di.unimi.it/LSR/Item?id=592

%LSR modified by P.P.Schneider on Feb.2014

% note: the effect of the bar number procedures is first displayed with all bar numbers visible, then with the default settings.
% these settings are only to demonstrate on one page

#(set-global-staff-size 18)
\layout {
  \context {
    \Score
    fontSize = #-3
    \override StaffSymbol.staff-space = #(magstep -3)
    \override StaffSymbol.thickness = #(magstep -3)
  }
}
music = \relative c' {
  \override Score.BarNumber.break-visibility = #all-visible
  e1 e e e e e  e2 \bar "!" \break e e1 e e e e e e
  \bar "||" \break
  \override Score.BarNumber.break-visibility = #begin-of-line-visible
  e1 ^\markup \teeny "default break-visibility" e e e e e e2 \bar "!" \break e e1 e e e e e e
  \bar "|."
}
\book {
  \markup "#all-bar-numbers-visible"
  \score { 
    { 
      \set Score.barNumberVisibility = #all-bar-numbers-visible 
      \bar "" %% added by P.P.Schneider on Feb.2014
      \music 
    } 
  }
  \markup "#(every-nth-bar-number-visible 3)"
  \score { 
    { 
      \set Score.barNumberVisibility = #(every-nth-bar-number-visible 3) 
      \music } 
  }
  \markup "#(modulo-bar-number-visible 3 2)"
  \score { 
    { 
      \set Score.barNumberVisibility = #(modulo-bar-number-visible 3 2) 
      \music 
    }	 
  }
  %
  % the following are only available with version 2.16.0 and higher:
	%
  \markup "#first-bar-number-invisible-save-broken-bars"
  \score { 
    { 
      \set Score.barNumberVisibility = #first-bar-number-invisible-save-broken-bars 
      \music } 
  }
  \markup "#first-bar-number-invisible-and-no-parenthesized-bar-numbers"
  \score { 
    { 
      \set Score.barNumberVisibility = #first-bar-number-invisible-and-no-parenthesized-bar-numbers 
      \music 
    }
  }
}
