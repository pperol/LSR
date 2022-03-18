%% http://lsr.dsi.unimi.it/LSR/Item?id=613

% LSR In 2_13_0 and earlier, the following
% LSR warning may be triggered multiple times:
% LSR  warning: Ignoring grob for slur: <grob>. avoid-slur not set?
% LSR This issue has been resolved in 2_13_1

#(define (parse-grob-sym grob-sym)
   (let* ((grob-str (symbol->string grob-sym))
          (dot-index (string-index grob-str #\.))
          (context (if dot-index
                       (string-take grob-str dot-index)
                       "Voice"))
          (grob (if dot-index
                    (substring grob-str (+ dot-index 1))
                    grob-str)))
     (cons context grob)))

hideCurvesFrom =
#(define-music-function
   (parser location grob-sym x-padding y-padding)
   (symbol? pair? pair?)
   (let* ((context (car (parse-grob-sym grob-sym)))
          (top-grob (cdr (parse-grob-sym grob-sym))))
     #{
        \override Tie.layer = #-2
        \override Slur.layer = #-2
        \override PhrasingSlur.layer = #-2

        \override $context . $top-grob #'avoid-slur = #'ignore
        \override $context . $top-grob #'layer = #-1
        \override $context . $top-grob #'stencil =
        #(lambda (grob)
           (define (get-stil-proc alist)
             ;; removes the first 'stencil entry from the grob-property
             ;; alist, implicitly created by this callback:
             ;;   (stencil . #<procedure #f (grob)>)
             ;; and then retrieves the original 'stencil procedure.
             (let ((stil-proc (ly:assoc-get 'stencil alist)))
               (if (procedure-name stil-proc)
                   stil-proc
                   (begin (set! alist (assoc-remove! alist 'stencil))
                          (get-stil-proc alist)))))
           (let* ((basic-props (ly:grob-basic-properties grob))
                  (stil-proc (get-stil-proc basic-props))
                  (this-stil (stil-proc grob)))
              (if (ly:stencil? this-stil)
                  (let* ((stil-x-ext (ly:stencil-extent this-stil 0))
                         (stil-y-ext (ly:stencil-extent this-stil 1))
                         (box-x-ext (cons (- (car stil-x-ext) (car x-padding))
                                          (+ (cdr stil-x-ext) (cdr x-padding))))
                         (box-y-ext (cons (- (car stil-y-ext) (car y-padding))
                                          (+ (cdr stil-y-ext) (cdr y-padding))))
                         (box-w (- (cdr box-x-ext) (car box-x-ext)))
                         (box-h (- (cdr box-y-ext) (car box-y-ext))))
                    (ly:stencil-add
                     (ly:make-stencil
                      (list 'embedded-ps
                            (ly:format
                             (string-append "gsave\n"
                                            "currentpoint translate\n"
                                            "1 setgray\n"
                                            "~4f ~4f ~4f ~4f rectfill\n"
                                            "grestore\n")
                             (car box-x-ext)
                             (car box-y-ext)
                             box-w
                             box-h))
                      stil-x-ext
                      stil-y-ext)
                     this-stil))
                  '())))
     #}))

revertHideCurvesFrom =
#(define-music-function (parser location grob-sym) (symbol?)
   (let ((context (car (parse-grob-sym grob-sym)))
         (top-grob (cdr (parse-grob-sym grob-sym))))
     #{
        \revert Tie.layer
        \revert Slur.layer
        \revert PhrasingSlur.layer
        \revert $context . $top-grob #'avoid-slur
        \revert $context . $top-grob #'layer
        \revert $context . $top-grob #'stencil
     #}))

%%%%%%%%%%%%%%%%%% EXAMPLE %%%%%%%%%%%%%%%%%%

\relative c {
  \repeat volta 2 {
    
    %% syntax: \hideCurvesFrom [grob] [x-padding] [y-padding]
    
    % always call \hideCurvesFrom before the curve starts:
    \hideCurvesFrom #'Fingering #'(0.3 . 0.3) #'(0 . 0)
    \hideCurvesFrom #'Staff.KeySignature #'(0.3 . 0.3) #'(0 . 0)
    \hideCurvesFrom #'Staff.TimeSignature #'(0.3 . 0.3) #'(0 . 0)
    
    % a negative padding value can prevent whiteout near an edge:
    \hideCurvesFrom #'Staff.Clef #'(0.3 . 0.3) #'(0 . -0.5)
    
    \clef bass
    \once \override TextScript.extra-offset = #'(-8 . 0)
    e2.\(^\markup \fontsize #-1 \italic {
      tacet la \concat { 1 \super \lower #0.5 ma } volta:
    }
    d4( |
    
    \clef treble \key g \major
    c''4)^2 c2 b4~ |
    \time 3/4
    b2\) 
    % updating a previously entered command:
    \hideCurvesFrom #'Staff.Clef #'(0.3 . 0.3) #'(0 . 0)
    fis4( |
    
    \clef bass \time 2/4
    d,4)
    % always call \hideCurvesFrom before the curve starts:
    \hideCurvesFrom #'Score.VoltaBracket #'(0.3 . 0.8) #'(3 . 0)
    e4( |
  }
  
  \alternative {
    { r2 | }
    {
      % revert commands independently as needed:
      \revertHideCurvesFrom #'Score.VoltaBracket
      d2)
    }
  }
  % revert commands when no longer needed:
  \revertHideCurvesFrom #'Fingering
  \revertHideCurvesFrom #'Staff.Clef
  \revertHideCurvesFrom #'Staff.KeySignature
  \revertHideCurvesFrom #'Staff.TimeSignature
}
