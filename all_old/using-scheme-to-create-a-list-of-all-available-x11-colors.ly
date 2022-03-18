%% http://lsr.di.unimi.it/LSR/Item?id=394
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/list-of-colors

#(ly:load "x11-color.scm")

% To show all available colors (~17 pages), replace
% (take x11-color-list 15) by x11-color-list
#(define-markup-list-command (listcolors layout props) ()
  (interpret-markup-list layout props
    (map (lambda (colorspec)
      (markup #:with-color (x11-color (car colorspec))
              #:filled-box '(-0.5 . 10) '(-1 . 3) 1
              (symbol->string (car colorspec))))
      (take x11-color-list 15))))

\markuplist \column-lines \listcolors
\markup "... (only the first 15 colors are shown)"
