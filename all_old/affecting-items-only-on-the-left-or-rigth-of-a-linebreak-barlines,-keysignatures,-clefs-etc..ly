%% http://lsr.dsi.unimi.it/LSR/Item?id=775
%% see also http://www.lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides

% Contributed by harm6
% Code is taken from output-lib.scm and modified.
% This snippet was developed with 2.14.2, but there is no difficulty with 2.12.2
% Several other Definitions and functions are possible.

%------------ Definitions

#(define (color-at-line-begin g)
  (if (and (ly:item? g)
	   (equal? (ly:item-break-dir g) RIGHT))
      (ly:grob-set-property! g 'color red)))
      
#(define (rotate-at-line-begin g)
  (if (and (ly:item? g)
	   (equal? (ly:item-break-dir g) RIGHT))
      (ly:grob-set-property! g 'rotation (list 145 0 0))))
      
#(define (translate-at-line-begin g)
  (if (and (ly:item? g)
	   (equal? (ly:item-break-dir g) RIGHT))
      (and (ly:grob-translate-axis! g -3.5 Y)
           (ly:grob-translate-axis! g -3.5 X))
      ))
      
#(define (color-at-line-end g)
  (if (and (ly:item? g)
	   (equal? (ly:item-break-dir g) LEFT))
      (ly:grob-set-property! g 'color green)))
         
#(define (rotate-at-line-end g)
  (if (and (ly:item? g)
	   (equal? (ly:item-break-dir g) LEFT))
      (ly:grob-set-property! g 'rotation (list 45 0 0))))
      
%---------- music-functions
 
% In the music-functions colors are to be specified like rgb-colors.

colorBarLineBeg =      
#(define-music-function (parser location color)(list?)
 (define (color-at-line-begin g)
  (if (and (ly:item? g)
	   (equal? (ly:item-break-dir g) RIGHT))
      (ly:grob-set-property! g 'color color)))
#{
        \once\override Staff.BarLine.after-line-breaking = #color-at-line-begin
#})

colorBarLineEnd =      
#(define-music-function (parser location color)(list?)
 (define (color-at-line-end g)
  (if (and (ly:item? g)
	   (equal? (ly:item-break-dir g) LEFT))
      (ly:grob-set-property! g 'color color)))
#{
        \once\override Staff.BarLine.after-line-breaking = #color-at-line-end
#})
%---------------------- Test ---------------------------------------------------

\paper {
        ragged-right =##f
        indent = 0
        line-width = 90
}

\relative g' {
        	\once\override Staff.Clef.after-line-breaking = #color-at-line-begin
        	\repeat volta 2 { c1 }
\break
        	\once\override Staff.BarLine.after-line-breaking = #translate-at-line-begin 
        	\repeat volta 2 { d }
\break
        	\once\override Staff.TimeSignature.after-line-breaking = #rotate-at-line-begin
        	\time 2/4
        	\repeat volta 2 { c2 }
\break
        	\once\override Staff.KeySignature.after-line-breaking = #color-at-line-end
        	\key cis\major 
        	\repeat volta 2 { dis }
\break
        	\once\override Staff.BarLine.after-line-breaking = #color-at-line-end
        	\once\override Staff.KeySignature.after-line-breaking = #rotate-at-line-begin
        	\once\override Staff.Clef.after-line-breaking = #rotate-at-line-end
        	\once\override Staff.TimeSignature.after-line-breaking = #color-at-line-begin
        	\clef alto
        	\time 4/8
        	\repeat volta 2 { cis }
\break
        	\colorBarLineBeg #'(0 1 0)
        	\time 2/4
        	\repeat volta 2 { dis, }
\break
	\colorBarLineEnd #'(0.6 0 1)
	\repeat volta 2 { cis }

} 
