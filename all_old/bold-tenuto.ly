%% http://lsr.di.unimi.it/LSR/Item?id=858
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/expressive-marks-attached-to-notes.fr.html

% by: ArnoldTheresius, supplemented by 'harm6'
%
%\paper {
%  #(set-paper-size "b7" 'landscape)
%  line-width          =  105 \mm
%  left-margin         =  10 \mm
%  indent              =   0 \mm
%}

\markup \vspace #1  % needed for proper display in the LSR, ok to remove in other contexts

%tested \version "2.22.0"



#(define (bold-tenuto-script-stencil grob)
   (let*
     ((scale (magstep (ly:grob-property grob 'font-size 0)))
      (dir (ly:grob-property grob 'direction 0))
      (script-stencil (ly:grob-property grob 'script-stencil))
      (tenuto-width 0.25) ;;; alter this value to modify the line width of the tenuto
      (tenuto-length 1.5) ;;; alter this value to modify the line length of the tenuto
      (tl (* -0.5 tenuto-length))
      (tr (* 0.5 tenuto-length))
      (ten-sil (make-line-stencil (* scale tenuto-width) (* scale tl) 0.0 (* scale tr) 0.0))
      (dot-sil (make-circle-stencil (* scale 0.15) (* scale 0.1) #t))
      (por-sil (ly:stencil-combine-at-edge 
                  ten-sil 
                  Y
                  (if (= dir 0)
                    -1
                    (* -1 dir))
                  dot-sil 
                  (* scale 0.4))))
   (if (and (pair? script-stencil) (pair? (cdr script-stencil)))
     (let* ((rv (cdr script-stencil))
            (script-type (if (<= dir 0) (car rv) (cdr rv))))
        (cond ((equal? script-type "tenuto")
               ten-sil)
              ((or (equal? script-type "uportato") (equal? script-type "dportato"))
               por-sil)
              (else (ly:script-interface::print grob))))
     (ly:script-interface::print grob))))

% define globally
\layout {
  \context {
    \Voice
    \override Script.stencil = #bold-tenuto-script-stencil
  }
}

{
  % alternatively: override locally (in voice)
  % \override Script.stencil = #bold-tenuto-script-stencil
  c'--^"bold tenuto / portato:" d'-- f'-- c''--
  c'-_ d'-_ f'-_ c''-_ \bar "||"
  \revert Script.stencil
  c'--^"original design:" d'-- f'-- c''--
  c'-_ d'-_ f'-_ c''-_ \bar "||"
}
