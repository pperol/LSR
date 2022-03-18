%% http://lsr.dsi.unimi.it/LSR/Item?id=125
%% Upgraded by P.P.Schneider on Feb. 2014
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/modifying-single-staves.fr.html#ossia-staves
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/bars.fr.html

\score {
  \relative c''
  \new StaffGroup 
  \with {
    \remove "System_start_delimiter_engraver"
%%% in comment\uncomment fomllowing lines for optional
    \override SpanBar.glyph-name = #"!" 
    %\override SpanBar.glyph-name = #";"
    %\override SpanBar.glyph-name = #""
  } 
  <<
  
    %% solution 1
    { 
      c1 c1
      <<
        { c1 c1 } 
        \new Staff 
        \with {
          \remove "Time_signature_engraver"
          fontSize = #-2
          \override StaffSymbol.staff-space = #(magstep -2)  
        } 
        { c,4^"ossia" es f fis g1 }
      >>
      c1 \break c c 
    }
  
    %% solution 2
    \new Staff 
    \with {
      fontSize = #-2
      \override StaffSymbol.staff-space = #(magstep -2)  
    } 
    { R1*2 c,4^"ossia" es f fis g1 R1 * 3 }
  
  >>
  \layout {
    ragged-right= ##t
    \context {
      \Staff 
      \RemoveEmptyStaves
    }
    \context {
      \Score
      \remove "System_start_delimiter_engraver"
    }
  }
}
