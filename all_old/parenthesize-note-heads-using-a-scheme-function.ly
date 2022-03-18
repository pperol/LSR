%% http://lsr.dsi.unimi.it/LSR/Item?id=186
%% see also http://www.lilypond.org/doc/v2.18/Documentation/notation/inside-the-staff#parentheses
%% see also http://lilypond.1069038.n5.nabble.com/LSR-v2-18-quot-Parenthesize-note-heads-using-a-Scheme-function-quot-interest-tc159509.html


#(define (parenthesize-callback callback)
   (define (parenthesize-stencil grob)
     (let* ((fn (ly:grob-default-font grob))
            (pclose (ly:font-get-glyph fn "accidentals.rightparen"))
            (popen (ly:font-get-glyph fn "accidentals.leftparen"))
            (subject (callback grob))            
            ;; get position of stem
            (stem-pos (ly:grob-property grob 'stem-attachment))            
            ;; remember old size
            (subject-dim-x (ly:stencil-extent subject X))
            (subject-dim-y (ly:stencil-extent subject Y)))

       ;; add parens
       (set! subject
             (ly:stencil-combine-at-edge 
              (ly:stencil-combine-at-edge subject X RIGHT pclose 0)
              X LEFT popen 0))

       ;; adjust stem position
       (set! (ly:grob-property grob 'stem-attachment)
             (cons (- (car stem-pos) 0.43) (cdr stem-pos)))

       ;; adjust size
       (ly:make-stencil
        (ly:stencil-expr subject)
        (interval-widen subject-dim-x 0.5)
        subject-dim-y)))
   
   parenthesize-stencil)

\relative c' {  
  c4 e
  \override NoteHead.stencil = #(parenthesize-callback ly:note-head::print)
  g4 bes
  a1
  \revert NoteHead.stencil
  a8 gis8 a2. 
}



