%% http://lsr.di.unimi.it/LSR/Item?id=293
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/creating-titles-headers-and-footers

%LSR modified by P.P.Schneider on Feb. 2014

\paper{
  oddHeaderMarkup = \markup
    \fill-line {
      \fromproperty #'header:title " " % This will make sure that the header is never completely empty, to
      % avoid some layout problems. Also, moving it in between the title and
      % the page number, makes these be typeset left and right aligned, respectively.
      \on-the-fly #print-page-number-check-first 
      \fromproperty #'page:page-number-string
    }

  evenHeaderMarkup = \markup
    \fill-line {
      \on-the-fly #print-page-number-check-first 
      \fromproperty #'page:page-number-string " "
      \fromproperty #'header:title
    }
}

\header {
  title = "This title will be repeated"
  subtitle = "whereas this subtitle won't"
}
         
\score { 
  \new Staff {
    \repeat unfold 4 {
      \repeat unfold 8 { c'8 c'8 c'8 c'8 } 
      \pageBreak
    }
  } 
}
