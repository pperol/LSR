#(define (make-note-req p d)
   (make-music 'NoteEvent
    'duration d
    'pitch p))

#(define (make-note elts)
   (make-music 'EventChord
    'elements elts))

#(define (seq-music-list elts)
   (make-music 'SequentialMusic
    'elements elts))

fooMusic = #(seq-music-list
             (list (make-note (list (make-note-req (ly:make-pitch 1 0 0) (ly:make-duration 2 0))))
                   (make-note (list (make-note-req (ly:make-pitch 1 1 0) (ly:make-duration 2 0))))))
     
\score { 
  \fooMusic 
}
