%% http://lsr.di.unimi.it/LSR/Item?id=891
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/graphic

bowtie = 
#(make-connected-path-stencil
  '((0 0.5)  ;; path coordinates
    (0.5 0 1.0 0 1.5 0.5)
    (1.5 -0.5)
    (1.0 0 0.5 0 0 -0.5)
    (0 0))
  0.1  ;; line thickness
  1  ;; X-axis scaling factor
  1  ;; Y-axis scaling factor
  #f  ;; automatically connect path to origin point? (0 0)
  #t)  % filled path?
  
{ \override NoteHead.stencil = \bowtie e'4 f' g' a' }


triangle = 
\markup \stencil 
#(make-connected-path-stencil
  '((1 2)  ;; path coordinates
    (2 0)
    (0 0))
  0.15  ;; line thickness
  1  ;; X-axis scaling factor
  1  ;; Y-axis scaling factor
  #f  ;; auto-connect path to origin point? (0 0)
  #t)  % filled path?

moon =
\markup \stencil
#(ly:stencil-translate
  (make-connected-path-stencil
   '((-6 -2 -6 7 0 5) 
     (-3 5 -3 0 0 0))
   0.15 
   0.5 
   0.5 
   #f 
   #f) 
  (cons 1.8 0)) % ly:stencil-translate coordinates

{ c'4 \mark \triangle c'4 c'4  c'4^\moon }

