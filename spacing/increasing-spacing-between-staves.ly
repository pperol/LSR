\version "2.18.0"

\header {
  texidoc = "
Vertical spacing is automatically set so that the layout of a score is
neither too cramped or loose.  Changing the distance between systems,
however, is easy to do. You may want to move systems closer together so
that more can fit on the page, for example.


Four keys are available for fine-tuned control, but you may find that
you can get the spacing you want with changes to just one or two.  The
output of this snippet is the result of a change to a single key,
@code{padding}. You may want to experiment with the commented-out line
below it, which contains the default values for
@code{system-system-spacing} and shows the syntax to use for changes in
groups. Numbers represent distances in staff-spaces. 


For more details you should consult Section 4.1 of the Notation
Reference. 

"
  doctitle = "Increasing spacing between staves"
}
%% http://lsr.di.unimi.it/LSR/Item?id=12

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LSR workaround:
#(set! paper-alist (cons '("snippet" . (cons (* 180 mm) (* 180 mm))) paper-alist))
\paper {
  #(set-paper-size "snippet")
  tagline = ##f
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%here starts the snippet:

\paper {
  % spacing variables may be changed individually:
  system-system-spacing.padding = #8
  % or as a group:
  %system-system-spacing =
    #'((basic-distance . 12)
       (minimum-distance . 8)
       (padding . 1)
       (stretchability . 60)) 
}

\score {
  \new Staff {
    \repeat unfold 96 { c''8[ c''] } 
  }
}

\layout {
   indent = 0\mm
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LSR workaround:
\markup\vspace #.5

