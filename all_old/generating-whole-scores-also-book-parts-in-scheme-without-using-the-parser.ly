%% http://lsr.dsi.unimi.it/LSR/Item?id=630
%% LSR This code was written by Nicolas Sceaux (http://nicolas.sceaux.free.fr/)
%% 

#(define-public (add-score parser score)
   (ly:parser-define! parser 'toplevel-scores
                      (cons score (ly:parser-lookup parser 'toplevel-scores))))

#(define-public (add-text parser text)
  (add-score parser (list text)))

#(define-public (add-music parser music)
  (collect-music-aux (lambda (score)
		       (add-score parser score))
                     parser
		     music))

#(define-public (toplevel-book-handler parser book)
   (map (lambda (score)
          (ly:book-add-score! book score))
        (reverse! (ly:parser-lookup parser 'toplevel-scores)))
   (ly:parser-define! parser 'toplevel-scores (list))
   (print-book-with-defaults parser book))

#(define-public (book-score-handler book score)
   (add-score parser score))

#(define-public (book-text-handler book text)
   (add-text parser text))

#(define-public (book-music-handler parser book music)
   (add-music parser music))

%%%


%% Just some example score to show how to use these functions:
#(define add-one-note-score #f)
#(let ((pitch 0))
  (set! add-one-note-score
        (lambda (parser)
          (let* ((music (make-music 'EventChord
                          'elements (list (make-music 'NoteEvent
                                            'duration (ly:make-duration 2 0 1/1)
                                            'pitch (ly:make-pitch 0 pitch 0)))))
                 (score (scorify-music music parser))
                 (layout (ly:output-def-clone $defaultlayout))
                 (note-name (case pitch
                              ((0) "do")
                              ((1) "ré")
                              ((2) "mi")
                              ((3) "fa")
                              ((4) "sol")
                              ((5) "la")
                              ((6) "si")
                              (else "huh")))
                 (title (markup #:large #:line ("Score with a" note-name))))
            (ly:score-add-output-def! score layout)
            (add-text parser title)
            (add-score parser score))
            (set! pitch (modulo (1+ pitch) 7)))))

oneNoteScore =
#(define-music-function (parser location) ()
   (add-one-note-score parser)
   (make-music 'Music 'void #t))

%%%

\book {
  \oneNoteScore
}


\book {
  \oneNoteScore
  \oneNoteScore
}

% Top-level scores are also handled correctly
\oneNoteScore
\oneNoteScore



