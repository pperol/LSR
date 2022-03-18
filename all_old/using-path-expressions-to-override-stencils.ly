%% http://lsr.di.unimi.it/LSR/Item?id=623
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/graphic

%{
  Note: since SVG path data needs an "M" or "m" at the
  beginning to start a new subpath, every path expression
  must begin with "rmoveto" (or "moveto") to work with the
  SVG backend.
%}

customClefStencilOne =
  #(ly:make-stencil
    `(path 0.2
	  `(rmoveto 0 0
	    rcurveto 0 0.75 1 0.75 1 0
	    rcurveto 0 -0.75 -1 -0.75 -1 0
	    rcurveto -1 0 -1 1.5 -0.5 1.5
	    rmoveto 0.5 -1.5
	    rcurveto -1 0 -1 -1.5 -0.5 -1.5
	    rmoveto 0.5 1.5
	    rmoveto 1 0
	    rcurveto 2.5 0 2.5 4 4 4
	    rmoveto -4 -4
	    rcurveto 2.5 0 2.5 -4 4 -4))
     (cons -0.5 1)
     (cons -3 5))
  
% a filled custom stencil
customClefStencilTwo = 
  #(ly:make-stencil
    ;; path line thickness is set to 0.1 
    `(path 0.1
          ;; path coordinates
	  `(moveto 0 0
	    curveto 0 1 0.7 2.5 1.5 1.5
            lineto 1.5 -3
            closepath)
          ;; path cap style
          'round
          ;; path join style
          'round
          ;; path filled?  #t or #f
          #t)
     ;; horizontal extent
     (cons 0 1.5)
     ;; vertical extent
     (cons -3 2))

% scheme function to automatically resize a custom stencil 
% when an individual staff is resized (uses font-size)
scaleCustomClefStencilTwo =
#(lambda (grob)
    (let* ((sz (ly:grob-property grob 'font-size 0.0))
           (mult (magstep sz)))
        (set! (ly:grob-property grob 'stencil) 
          (ly:stencil-scale
            customClefStencilTwo
            mult mult))))
  
customClefOne = \override Staff.Clef.stencil = \customClefStencilOne
customClefTwo = \override Staff.Clef.stencil = \scaleCustomClefStencilTwo
normalClefs = \revert Staff.Clef.stencil

music =
\relative c' {
  \customClefOne
  \clef "alto"
  c1 g1
  \customClefTwo
  \clef "bass"
  c1 g1
  \normalClefs
  \clef "treble"
  c1 g1
  \clef "alto"
  c1 g1
}
<<
\new Staff \with {
    fontSize = #-3
    \override StaffSymbol.staff-space = #(magstep -3)
    \override StaffSymbol.thickness = #(magstep -3)
}
\music

\new Staff 
\music

\new Staff \with {
    fontSize = #2
    \override StaffSymbol.staff-space = #(magstep 2)
    \override StaffSymbol.thickness = #(magstep 2)
}
\music
>>
