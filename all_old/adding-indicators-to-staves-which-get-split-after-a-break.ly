%% http://lsr.dsi.unimi.it/LSR/Item?id=650
%% Updated/modified by P.P.Schneider (2014 for v.2.18)

%LSR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LSR %% Store the following until
%LSR %%   %% end of include file
%LSR %% as splitStaffBarLine-1.0.ily.
%LSR %% To use it in your projects, write
%LSR %%   \include "<path-to-file/>splitStaffBarLine-1.0.ily"
%LSR %% to define the commands described below.
%LSR %%
%LSR %% Cheers,
%LSR %%   Alexander
%LSR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LSR
%LSR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LSR %% splitStaffBarLine
%LSR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LSR %% Version 1.0
%LSR %% 2009, Alexander Kobel (www.a-kobel.de)
%LSR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LSR
%LSR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LSR %% Defines the
%LSR %%   \splitStaffBarLine
%LSR %% command, which adds arrows in north-east and south-east
%LSR %% directions at a bar line, to denote that several voices
%LSR %% sharing a staff will each continue on a staff of their own in
%LSR %% the next system.
%LSR %% Automatically inserts a break at this position, otherwise
%LSR %% the symbol does not make any sense.
%LSR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LSR %% As a side-effect, defines the markup command
%LSR %%   \arrow-at-angle <angle> <length> <fill>
%LSR %% as a helper function, which draws an arrow of length <length>
%LSR %% at an angle of <angle> (in degrees).
%LSR %% If <fill> = #t, the arrowhead is filled.
%LSR %% Internally uses the fontsize and thickness properties, as
%LSR %% \arrow-head and \draw-line do.
%LSR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LSR
%LSR
%LSR %% This should also work with older version, probably up
%LSR %% to <= 2.10. Please report if this is the case.

%{ Original snippet :

#(define-markup-command (arrow-at-angle layout props angle-deg length fill)
   (number? number? boolean?)
   (let* (
          ;; PI-OVER-180 and degrees->radians are taken from flag-styles.scm
          (PI-OVER-180 (/ (atan 1 1) 45))
          (degrees->radians (lambda (degrees) (* degrees PI-OVER-180)))
          (angle-rad (degrees->radians angle-deg))
          (target-x (* length (cos angle-rad)))
          (target-y (* length (sin angle-rad))))
     (interpret-markup layout props
                       (markup
                        #:translate (cons (/ target-x 2) (/ target-y 2))
                        #:rotate angle-deg
                        #:translate (cons (/ length -2) 0)
                        #:concat (#:draw-line (cons length 0)
                                              #:arrow-head X RIGHT fill)))))

splitStaffBarLineMarkup = \markup \with-dimensions #'(0 . 0) #'(0 . 0) {
  \combine
    \arrow-at-angle #45 #(sqrt 8) ##f
    \arrow-at-angle #-45 #(sqrt 8) ##f
}

splitStaffBarLine = {
  \once \override Staff.BarLine.stencil =
    #(lambda (grob)
       (ly:stencil-combine-at-edge
        (ly:bar-line::print grob)
        X RIGHT
        (grob-interpret-markup grob splitStaffBarLineMarkup)
        0))
  \break
}

\paper {
  ragged-right = ##t
  short-indent = 5\mm
}

\score {
  <<
    \new ChoirStaff <<
      \new Staff \with { instrumentName = #"High I + II" } {
        <<
          \repeat unfold 4 f''1
          \\
          \repeat unfold 4 d''1
        >>
        \splitStaffBarLine
      }
      \new Staff \with { instrumentName = #"Low" } {
        <<
          \repeat unfold 4 b'1
          \\
          \repeat unfold 4 g'1
        >>
      }

      \new Staff \with { shortInstrumentName = #"H I" } {
        R1*4
        \repeat unfold 2 { r4 f''2 r4 } \repeat unfold 2 e''1
      }
      \new Staff \with { shortInstrumentName = #"H II" } {
        R1*4
        \repeat unfold 4 b'2 \repeat unfold 2 c''1
      }
      \new Staff \with { shortInstrumentName = #"L" } {
        R1*4
        <<
          \repeat unfold 4 g'1
          \\
          \repeat unfold 4 c'1
        >>
      }
    >>
  >>
  \layout {
    \context {
      \Staff \RemoveEmptyStaves
      \override VerticalAxisGroup.remove-first = ##t
    }
  }
}

%}

#(define-markup-command (arrow-at-angle layout props angle-deg length fill)
  (number? number? boolean?)
  (let* (
      (PI-OVER-180 (/ (atan 1 1) 34))
      (degrees->radians (lambda (degrees) (* degrees PI-OVER-180)))
      (angle-rad (degrees->radians angle-deg))
      (target-x (* length (cos angle-rad)))
      (target-y (* length (sin angle-rad))))
    (interpret-markup layout props
      (markup
      #:translate (cons (/ target-x 2) (/ target-y 2))
      #:rotate angle-deg
      #:translate (cons (/ length -2) 0)
      #:concat (#:draw-line (cons length 0)
      #:arrow-head X RIGHT fill)))))

splitStaffBarLine = {
  \once \override Staff.BarLine.stencil =
  #(lambda (grob)
    (ly:stencil-combine-at-edge
    (ly:bar-line::print grob)
    X RIGHT
    (grob-interpret-markup grob #{
      \markup\with-dimensions #'(0 . 0) #'(0 . 0) {
        %%%%%%%%%%%%%%%%%%%%%%% ATTENTION %%%%%%%%%%%%%%%%%%%%%%%%
        %%%%% translation X à régler en fonction de l'armure %%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        \translate #'(5.95 . .14)\arrow-at-angle #45 #(sqrt 8) ##t
        \translate #'(5.35 . -.13)\arrow-at-angle #-45 #(sqrt 8) ##t }#})
    0))
  \break
}

convDownStaffBarLine = {
  \once \override Staff.BarLine.stencil =
  #(lambda (grob)
    (ly:stencil-combine-at-edge
    (ly:bar-line::print grob)
    X RIGHT
    (grob-interpret-markup grob #{
        \markup\with-dimensions #'(0 . 0) #'(0 . 0) {
          %%%%%%%%%%%%%%%%%%%%%%% ATTENTION %%%%%%%%%%%%%%%%%%%%%%%%
          %%%%% translation X à régler en fonction de l'armure %%%%%
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          \translate #'(5.3 . -.13)\arrow-at-angle #-45 #(sqrt 8) ##t }#})
      0))
  \break
}

convUpStaffBarLine = {
  \once \override Staff.BarLine.stencil =
  #(lambda (grob)
    (ly:stencil-combine-at-edge
    (ly:bar-line::print grob)
    X RIGHT
    (grob-interpret-markup grob #{
        \markup\with-dimensions #'(0 . 0) #'(0 . 0) {
          %%%%%%%%%%%%%%%%%%%%%%% ATTENTION %%%%%%%%%%%%%%%%%%%%%%%%
          %%%%% translation X à régler en fonction de l'armure %%%%%
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          \translate #'(5.28 . .14)\arrow-at-angle #45 #(sqrt 8) ##t }#})
      0))
  \break
}


\paper {
  ragged-right = ##t
  short-indent = 5\mm
  left-margin = 15\mm
  right-margin = 15\mm
}

\score {
  <<
    \new ChoirStaff <<
      \new Staff 
      \with { 
        instrumentName = #"H I + H II"
      } {
        \key f\minor
        <<
          \repeat unfold 4 f''1
          \\
          \repeat unfold 4 des''1
        >>
        \key f\major
        \splitStaffBarLine
      }
      \new Staff \with { instrumentName = #"Low" } {
        \key f\minor
        <<
          \repeat unfold 4 bes'1
          \\
          \repeat unfold 4 g'1
        >>
        \key f\major
      }

      \new Staff \with { shortInstrumentName = #"I" } {
        \key f \major
        R1*4
        \repeat unfold 2 { r4 f''2 r4 } \repeat unfold 2 e''1
        \key f\minor
        \convDownStaffBarLine
      }
      \new Staff \with { shortInstrumentName = #"II" } {
        \key f \major
        R1*4
        \repeat unfold 4 bes'2 \repeat unfold 2 c''1
        \key f\minor
        \convUpStaffBarLine
      }
      
      \new Staff \with { shortInstrumentName = #"L" } {
        \key f\major
        R1*4
        <<
          \repeat unfold 4 g'1
          \\
          \repeat unfold 4 c'1
        >>
        \key f\minor
      }
      
      \new Staff 
      \with { 
        shortInstrumentName = #"I+II"
      } {
        \key f\minor
        R1*8
        <<
          \repeat unfold 4 f''1
          \\
          \repeat unfold 4 des''1
        >>
      }
      \new Staff \with { shortInstrumentName = #"L" } {
        \key f\minor
        R1*8
        <<
          \repeat unfold 4 bes'1
          \\
          \repeat unfold 4 g'1
        >>
      }
    >>
  >>
  \layout {
    \context {
      \Staff \RemoveEmptyStaves
      \override VerticalAxisGroup #'remove-first = ##t
    }
  }
}
