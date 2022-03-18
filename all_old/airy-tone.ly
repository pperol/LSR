%% http://lsr.di.unimi.it/LSR/Item?id=611
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/woodwind-diagrams


#(define (airohalf radius height thick) 
    (string-append "gsave
                    /msellipse {
                          /endangle exch def
                          /startangle exch def
                          /yrad exch def
                          /xrad exch def
                          /y exch def
                          /x exch def
                          /savematrix matrix currentmatrix def
                          x y translate
                          xrad yrad scale
                          0 0 1 startangle endangle arc
                          savematrix setmatrix
                      } def
                    /rad " (number->string radius) " def
                    /offset " (number->string height) " rad mul def
                    /ecenter 0 offset add def
                    /xradius rad rad mul offset offset mul sub sqrt def
                    /yradius rad offset sub def
                    " (number->string thick) " setlinewidth
                    currentpoint translate
                    0 0 moveto
                    newpath
                            0 rad rad 0 360 arc
                            fill
                    0 rad translate
                    1 1 1 setcolor
                    newpath
                            0 ecenter xradius yradius 0 -180 msellipse
                            closepath
                            fill
                    0 0 rad sub translate
                    0 0 0 setcolor
                    newpath
                            0 rad rad 0 360 arc
                            stroke
                    grestore"))

#(define (airuhalf radius height thick) 
    (string-append "gsave
                    /msellipse {
                          /endangle exch def
                          /startangle exch def
                          /yrad exch def
                          /xrad exch def
                          /y exch def
                          /x exch def
                          /savematrix matrix currentmatrix def
                          x y translate
                          xrad yrad scale
                          0 0 1 startangle endangle arc
                          savematrix setmatrix
                      } def
                    /rad " (number->string radius) " def
                    /offset " (number->string height) " rad mul def
                    /ecenter 0 offset sub def
                    /xradius rad rad mul offset offset mul sub sqrt def
                    /yradius 0 rad offset sub sub def
                    " (number->string thick) " setlinewidth
                    currentpoint translate
                    0 0 moveto
                    newpath
                            0 rad rad 0 360 arc
                            stroke
                    0 rad translate
                    newpath
                            0 ecenter xradius yradius 0 -180 msellipse
                            closepath
                            fill
                    grestore"))


#(define-markup-command (airytone layout props radius height thick)
   (number? number? number?)
   (let ((longstring ""))
     (set! height (max (min height 1) 0))
     (if (> height 0.5)
         (set! longstring (airohalf radius (* 2 (- height 0.5)) thick))
         (set! longstring (airuhalf radius (- 1 (* 2 height)) thick)))
     (ly:make-stencil
      (list 'embedded-ps longstring)
      (cons 0 0) (cons 0 2))))

\relative c' { 
  \once \override TextSpanner.bound-details.left.text =
    \markup { \airytone #1.0 #-0.2 #0.1 } 
  \once \override TextSpanner.bound-details.right.text =
    \markup { \airytone #1.0 #0.7 #0.1 } 
  e1\startTextSpan ~
  e1 ~ 
  \once \override TextSpanner.bound-details.left.text = \markup \null
  \once \override TextSpanner.bound-details.right.text =
    \markup { \airytone #1.0 #0.4 #0.1 } 
  e1\stopTextSpan\startTextSpan ~
  e1 ~
  e1\stopTextSpan
}
