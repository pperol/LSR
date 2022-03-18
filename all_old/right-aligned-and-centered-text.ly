%% http://lsr.di.unimi.it/LSR/Item?id=765
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/formatting-text
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/text

% Defines right-aligned and centered long text with the possibility to set the baseline-skip as required. 
% Code is taken from ./scm/define-mark-up-commands.scm and just slightly modified.
% Author: harm6 from the german lilypondforum


#(define (general-column align-dir baseline mols)
  (let* ((aligned-mols (map (lambda (x) (ly:stencil-aligned-to x X align-dir)) mols)))
    (stack-lines -1 0.0 baseline aligned-mols)))
    
#(define-markup-command (textRight layout props args)(markup-list?)
  #:properties ((baseline-skip))
  (general-column  RIGHT baseline-skip (wordwrap-internal-markup-list layout props #f args)))

#(define-markup-command (textCenter layout props args)(markup-list?)
  #:properties ((baseline-skip))
  (general-column CENTER baseline-skip (wordwrap-internal-markup-list layout props #f args)))


% ------------------------------------------------------------------------------

% example

\markup {
      \column { 
	\fill-line {
	\null
	\override #'(baseline-skip . 4)
	\override #'(line-width . 40)\textRight {
	Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
	do eiusmod tempor incididunt ut labore et dolore magna aliqua.
	Ut enim ad minim veniam, quis nostrud exercitation ullamco
	laboris nisi ut aliquip ex ea commodo consequat.}
	}
	
	\null\null\null 
	
	\fill-line {
	\null
	\override #'(baseline-skip . 6)
	\override #'(line-width . 40)\textCenter {
	Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
	do eiusmod tempor incididunt ut labore et dolore magna aliqua.
	Ut enim ad minim veniam, quis nostrud exercitation ullamco
	laboris nisi ut aliquip ex ea commodo consequat.} 
	\null
	}
	
	\null\null\null      
	
	% common wordwrap:
	\fill-line {
	\override #'(line-width . 40)\wordwrap {
	Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
	do eiusmod tempor incididunt ut labore et dolore magna aliqua.
	Ut enim ad minim veniam, quis nostrud exercitation ullamco
	laboris nisi ut aliquip ex ea commodo consequat.} 
	\null
	}
      }
}


