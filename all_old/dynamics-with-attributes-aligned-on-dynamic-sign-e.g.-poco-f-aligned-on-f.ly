%% http://lsr.di.unimi.it/LSR/Item?id=739
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/writing-text#text-spanners


% calculate x-alignment based on attribute text + dynamic text
% this has to be a markup-command to get stencil-extent based on (interpret-markup layout props ...)
#(define-markup-command (center-dyn layout props atr-text dyn)(markup? string?)
  "x-align on center of dynamic"
  (let* (
          (text (string-append atr-text " "))
          (atr-stencil (interpret-markup layout props (markup #:normal-text #:italic text)))
          (dyn-stencil (interpret-markup layout props (markup #:dynamic dyn)))
          (atr-x-ext (ly:stencil-extent atr-stencil X))
          (dyn-x-ext (ly:stencil-extent dyn-stencil X))
          (atr-x (- (cdr atr-x-ext)(car atr-x-ext)))
          (dyn-x (- (cdr dyn-x-ext)(car dyn-x-ext)))
          (x-align
            (* (-
                 (/ (+ atr-x (/ dyn-x 2)) (+ atr-x dyn-x) )
                 0.5) 2)
          )
        )
        (interpret-markup layout props (markup #:halign x-align #:concat (#:normal-text #:italic text #:dynamic dyn)))
))
% define a 'new' attributed dynamic script
#(define (make-atr-dynamic-script atr dyn)
        (let ((dynamic (make-dynamic-script (markup #:center-dyn atr dyn))))
             (ly:music-set-property! dynamic 'tweaks (acons 'X-offset 0 (ly:music-property dynamic 'tweaks)))
             dynamic))

% define some attributed dynamics
pocof = #(make-atr-dynamic-script "poco" "f")
menof = #(make-atr-dynamic-script "meno" "f")
subp = #(make-atr-dynamic-script "subito" "p")

\relative c'' {
  r4 c\pocof d e | d\ff d cis eis ~ | eis1\subp | r4 b\menof c\f r4
}
