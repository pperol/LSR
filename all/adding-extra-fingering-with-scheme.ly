addScript =
#(define-music-function (script music)
   (ly:event? ly:music?)
   (map-some-music
    (lambda (mus)
      (define (append-script-at! prop)
        (set! (ly:music-property mus prop)
              (append (ly:music-property mus prop)
                      (list (ly:music-deep-copy script))))
        mus)
      (case (ly:music-property mus 'name)
        ((EventChord)
         (append-script-at! 'elements))
        ((NoteEvent)
         (append-script-at! 'articulations))
        (else #f)))
    music))

\score {
  {
    \addScript _6 { c'4-3 <c' e' g'> }
  }
}
