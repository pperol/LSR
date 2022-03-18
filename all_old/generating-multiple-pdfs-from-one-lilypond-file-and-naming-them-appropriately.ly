%% http://lsr.dsi.unimi.it/LSR/Item?id=389

% LSR This snippet was originally written for \version "2.22.0"


vI = \relative c'' { g8 a b4 c d | e2 e,8 e( g4) }
vII = \relative c' { c4 d e f | g f d c }
va = \relative c' { \clef "tenor" c2 c2~ | c1 }
vcb = \relative c { \clef "bass" c4 b a g | f g a c }


\header { title = "Multiple Books in one score" }

% The output file will be named after the source file
% (default behavior)

\book {
  \score {
    \new Staff << \vI >>
  }
}

% The output will now be called *-VI-1.pdf
#(define output-suffix "VI")
\book {
  \score {
    \new Staff << \vI >>
  }
  \header {instrument = "Violino I"}
}

% The output will now be called *-VII-2.pdf
#(define output-suffix "VII")
\book {
  \score {
    \new Staff << \vII >>
  }
  \header {instrument = "Violino II"}
}

% The output will now be called *-Va-3.pdf
#(define output-suffix "Va")
\book {
  \header {instrument = "Viola"}
  \score {
    \new Staff << \va >>
  }
}

% The output will now be called *-VcB-4.pdf
#(define output-suffix "VcB")
\book {
  \header {instrument = "Violoncello e Basso"}
  \score {
    \new Staff << \vcb >>
  }
}

% The output will now be called *-FullScore-5.pdf
#(define output-suffix "FullScore")
\book {
  \header { }
  \score {
    \new StaffGroup <<
      \new Staff = vISt << 
            \set Staff.instrumentName = "Violino I" 
            \set Staff.shortInstrumentName = "V.I" 
            \vI >>
      \new Staff = vIISt << 
            \set Staff.instrumentName = "Violino II" 
            \set Staff.shortInstrumentName = "V.II" 
            \vII >>
      \new Staff = vaSt << 
            \set Staff.instrumentName = "Viola" 
            \set Staff.shortInstrumentName = "Va." 
            \va >>
      \new Staff = vISt << 
            \set Staff.instrumentName = \markup \column {"Violoncello" "e Basso"}
            \set Staff.shortInstrumentName = "Vc/B." 
            \vcb >>
    >>
  }
}
