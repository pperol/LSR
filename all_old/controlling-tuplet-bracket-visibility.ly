%% http://lsr.di.unimi.it/LSR/Item?id=337
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-rhythms

%LSR modified by P.P.Schneider on Feb.2014 for v2.18

music = \relative c'' {
  \tuplet 3/2 { c16[ d e } f8]
  \tuplet 3/2 { c8 d e }
  \tuplet 3/2 { c4 d e }
}

\new Voice {
  \relative c' {
    << \music s4^"default" >>
    \override TupletBracket.bracket-visibility = #'if-no-beam
    << \music s4^"'if-no-beam" >>
    \override TupletBracket.bracket-visibility = ##t
    << \music s4^"#t" >>
    \override TupletBracket.bracket-visibility = ##f
    << \music s4^"#f" >>
    %% v2.18 :
    \omit TupletBracket
    << \music s4^"omit" >>
  }
} 
