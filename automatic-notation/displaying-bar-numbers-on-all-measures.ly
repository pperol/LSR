\version "2.18.0"

\header {
  texidoc = "
By default, bar numbers are printed only in the first measure.   This
setting can be overridden, so that bar numbers appear on every measure.



"
  doctitle = "Displaying bar numbers on all measures"
}
%% http://lsr.di.unimi.it/LSR/Item?id=93
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/bars#bar-lines

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LSR workaround:
#(set! paper-alist (cons '("snippet" . (cons (* 200 mm) (* 50 mm))) paper-alist))
\paper {
  #(set-paper-size "snippet")
  tagline = ##f
}

\markup\vspace #.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%here starts the snippet:

\score{
  \relative c'{
    c1 c c
    \override Score.BarNumber.break-visibility = #end-of-line-invisible
    \break
    c c c
  }
  \layout{ raggedright = ##t }
}

