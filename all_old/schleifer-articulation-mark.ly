%% http://lsr.di.unimi.it/LSR/Item?id=720
%% see also http://lilypond.org/doc/v2.18/Documentation/notation/graphic

%LSR contributed by Valentin as per request http://code.google.com/p/lilypond/issues/detail?id=503

schleifer =
#(define-music-function (parser location start) (ly:music?)
  #{\once \override Slur $'direction = #UP
    \once \override Slur $'stencil = $(lambda (grob)
    (let* ((slur-stencil (ly:slur::print grob))
           (Y-ext (ly:stencil-extent slur-stencil Y))
           (text-stencil (ly:text-interface::print grob))
           (prall-stencil (ly:stencil-translate text-stencil
                           (cons 2.5 (car Y-ext))))
           (combo-stencil (ly:stencil-combine-at-edge
                           prall-stencil X RIGHT
                           slur-stencil 0))
            (combo-X-ext (ly:stencil-extent combo-stencil X)))
      (ly:stencil-translate combo-stencil (cons 0 -1))))
    \once \override Slur.positions = #'(-1 . 2)
    \once \override Slur.text = \markup {
    \musicglyph #"scripts.prall" }
    \once \override Slur $'control-points = $(lambda (grob)
    (let* ((coords (ly:slur::calc-control-points grob))
            (point-0 (list-ref coords 0))
            (point-1 (list-ref coords 1))
            (point-2 (list-ref coords 2))
            (point-3 (list-ref coords 3)))
    (set-car! point-0 (+ (car point-0) 2))
    (set-car! point-1 (+ (car point-1) 1.5))
    (set-car! point-2 (+ (car point-2) -1))
    (set-car! point-3 (+ (car point-3) -1))
    coords))
    s1*0( $start
    \once \override Rest.transparent = ##t
    \once \override Rest.X-extent = #'(0 . 5)
    \grace r1
    s1*0) #})

\relative c'' { \schleifer a2 d }



