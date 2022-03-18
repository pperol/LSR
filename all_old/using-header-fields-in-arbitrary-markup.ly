%% http://lsr.di.unimi.it/LSR/Item?id=467
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/creating-titles-headers-and-footers

% This function is originally copied from mark-up-title (file scm/titling.scm), 
% which is lilypond's internal function to handle the title markups. I needed 
% to replace the scopes and manually add the $defaultheader (which is internally 
% done in paper-book.cc before calling mark-up-title. Also, I don't extract the 
% markup from the header block, but use the given markup.
%
% I'm not sure if I really need the page properties in props, too... But I 
% suppose it does not hurt, either.
#(define-markup-command (markupWithHeader layout props markup) (markup?)
   "Interpret the given markup with the header fields added to the props.
This way, one can re-use the same functions (using fromproperty 
#'header:field) in the header block and as top-level markup."
   (let* (
	  ;; TODO: If we are inside a score, add the score's local header block, too!
	  ;; Currently, I only use the global header block, stored in $defaultheader
	  (scopes (list $defaultheader))
	  (alists (map ly:module->alist scopes))
	  (prefixed-alist
	   (map (lambda (alist)
		  (map (lambda (entry)
			 (cons
			  (string->symbol (string-append "header:"
							 (symbol->string
							  (car entry))))
			  (cdr entry)))
		       alist))
		alists))
	  (props (append prefixed-alist
			 props
			 (layout-extract-page-properties layout))))
     (interpret-markup layout props markup)))

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% test markup containing references to header fields:
testMarkup = \markup {
  \justify {
    This is a text inserted using the new \typewriter{"\\markupWithHeader"} 
    command to allow using header fields 
    (via "\fromproperty #'header:fieldname"). For example, the title field 
    is \fontsize #+3 \fromproperty #'header:title and 
    the composer is \fontsize #+3 \fromproperty #'header:composer
  }
}

\header { 
  title = "My own title" 
  composer = "Someone" 
  piece = "Global piece name"
}

% Print out the markups. The \fromproperty #'header:field are now properly
% interpreted.
\markup\markupWithHeader \testMarkup

\markup\markupWithHeader {
  \wordwrap {
    This is a long text, which is now able to use the header fields 
    (via "\fromproperty #'header:fieldname"). For example, the title field 
    of this score is: \fromproperty #'header:title and the composer is: 
    \fromproperty #'header:composer
  }
}
