%% http://lsr.di.unimi.it/LSR/Item?id=864
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/graphic

% This has no visible effect, it just redoes the existing stem stencil.
% You can use this as a base.
#(define (path-stem grob)
   (if (ly:stencil? (ly:stem::print grob))
     (let* ((stencil (ly:stem::print grob))
            (X-ext (ly:stencil-extent stencil X))
            (Y-ext (ly:stencil-extent stencil Y))
            (width (interval-length X-ext))
            (len (interval-length Y-ext)))
   
       (ly:stencil-translate
         (grob-interpret-markup grob
           (markup
             (#:path width
               (list (list 'moveto 0 0)
                     (list 'lineto 0 len)))))
         (cons 0 (interval-start Y-ext))))
      #f))

% This is an example of what can be done with the rewritten stencil.
#(define (lightning-stem grob)
   (if (ly:stencil? (ly:stem::print grob))
     (let* ((stencil (ly:stem::print grob))
            (X-ext (ly:stencil-extent stencil X))
            (Y-ext (ly:stencil-extent stencil Y))
            (width (interval-length X-ext))
            (len (interval-length Y-ext)))
   
       (ly:stencil-translate
         (grob-interpret-markup grob
           (markup
             (#:path width
               (list (list 'moveto 0 0)
                     (list 'lineto (* len 0.1) (* len 0.6))
                     (list 'lineto (- (* len 0.1)) (* len 0.4))
                     (list 'lineto 0 len)))))
         (cons 0 (interval-start Y-ext))))
     #f))

\relative c' {
  \override Stem.stencil = #path-stem
  | c1
  | c8 d8 e8 f8 g8 f8 e8 d8 c2 c2
  \override Stem.stencil = #lightning-stem
  | c1
  | c8 d8 e8 f8 g8 f8 e8 d8 c2 c2
}
