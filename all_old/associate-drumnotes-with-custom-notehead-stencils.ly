%% http://lsr.di.unimi.it/LSR/Item?id=617
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/modifying-stencils


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Here are the stencils defined %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (circSlash grob)
   (let* ((line-thickness (ly:staff-symbol-line-thickness grob))
          (width (+ line-thickness 1))
          (stem-thickness (* line-thickness 1.3))
          (radius (/ (- width stem-thickness) 2)))
     (ly:make-stencil (list 'embedded-ps
                            (string-append "
          /line-thickness " (number->string line-thickness) " def
          /stem-thickness " (number->string stem-thickness) " def
          /radius " (number->string radius) " def
          /width " (number->string width) " def
          /half-width width 2 div def
          /x0 half-width def
          /y0 0 def
          /x1 width stem-thickness 2 div sub def
          /y1 half-width stem-thickness 2 div sub def
          /x2 stem-thickness 2 div def
          /y2 half-width neg stem-thickness 2 div add def

          gsave
          currentpoint translate
          stem-thickness setlinewidth
          newpath
          x0 y0 radius 0 360 arc
          stroke

          newpath
          1 setlinecap
          x1 y1 moveto
          x2 y2 lineto
          stroke
          grestore"))
                      (cons 0 width)
                      (cons 0 0))))

#(define plus
   (ly:make-stencil (list 'embedded-ps
      "gsave
       currentpoint translate
       newpath
       -0.05 0 moveto
       1.05 0 lineto
       closepath
       0.2 setlinewidth
       stroke
       
       newpath
       0.5 -0.45 moveto
       0.5 0.45 lineto
       closepath
       0.2 setlinewidth
       stroke
       grestore" )
      (cons -0.15 1.15)
      (cons 0 0)))
      
parallelogram =
  #(ly:make-stencil (list 'embedded-ps
    "gsave
      currentpoint translate
      newpath
      0 0.25 moveto
      1.3125 0.75 lineto
      1.3125 -0.25 lineto
      0 -0.75 lineto
      closepath
      fill
      grestore" )
    (cons 0 1.3125)
    (cons 0 0))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Here ends the stencil definition. %%%
%%%   The actual function follows.    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
#(define stencil-mapping
   (list
    (cons 'bassdrum parallelogram)
    (cons 'hightom circSlash)
    (cons 'lowtom plus)
    (cons 'snare circSlash)))

#(define (mod-notehead music)
   (if (eq? (ly:music-property music 'name) 'EventChord)
       (let ((n (length (ly:music-property music 'elements))))
         (do ((i 0 (1+ i))) ((= i n))
           (let* ((ne (list-ref (ly:music-property music 'elements) i))
                  (dt (ly:music-property ne 'drum-type))
                  (st (assoc dt stencil-mapping)))
             (if st
                 (ly:music-set-property! ne 'tweaks (list (cons 'stencil (cdr st)))))))))
   music)

customHeads =
#(define-music-function (parser location music) (ly:music?)
   (music-map (lambda (x) (mod-notehead x)) music))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Below is a short sample. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
\new DrumVoice \drummode {
  \customHeads { <sn hh bd>4 tomh toml <toml sn> }
}
