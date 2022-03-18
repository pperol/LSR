%% http://lsr.dsi.unimi.it/LSR/Item?id=306
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/creating-titles-headers-and-footers

%LSR modified/updated by P.P.Schneider on Feb. 2014

\header {
  title = "Formatting of piece headers"
}

\paper {
   scoreTitleMarkup = \markup { 
    \column {
      \on-the-fly #print-all-headers { \bookTitleMarkup \hspace #1 }
      \fill-line {
        \fontsize #3 \bold \fromproperty #'header:piece
        \fromproperty #'header:opus
      }
    }
  }
}

\markuplist { 
  \vspace #1
  \fill-line { 
    \justify-string # "If you have multiple pieces in a large work, 
        you can use multiple score parts and use the piece header 
        field to supply a title for each of the pieces. However, 
        the font is very small. You can either directly put the 
        markup into the piece=... header field, or better re-define 
        the scoreTitleMarkup function in the paper section."
  } 
  \vspace #1
}

\score { 
  \context Staff << { c'1 | R1 } >>
  \header{ piece="Piece 1" }
}

\score { 
  \context Staff << { c'1 | R1 } >>
  \header{ piece="Piece 2" }
}
